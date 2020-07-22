package com.tm.cgv.member;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tm.cgv.auth.AuthRepository;
import com.tm.cgv.auth.AuthVO;
import com.tm.cgv.auth.RoleEnum;
import com.tm.cgv.util.FileManager;
import com.tm.cgv.util.FilePathGenerator;
import com.tm.cgv.util.GenerateRandomNumber;
import com.tm.cgv.util.MemberInfoMaker;
import com.tm.cgv.util.Pager;
import com.tm.cgv.util.SmsSender;

@Service
@Transactional
public class MemberService implements UserDetailsService {
    
	@Autowired
	private MemberRepository memberRepository;
	

	@Autowired
	private AuthRepository authRepository;

	@Autowired
	private MemberInfoMaker memberInfoMaker;
	
	@Autowired
	private SmsSender smsSender;

	@Autowired
	RedisTemplate<String, Object> redisTemplate;
	
	@Autowired
	private FilePathGenerator filePathGenerator;
	
	@Autowired
	private FileManager fileManager;
	
	@Value("${board.member.filePath}")
	private String filePath;
	
    @Override
    public MemberVO loadUserByUsername(String username) throws UsernameNotFoundException {
        
    	MemberBasicVO memberBasicVO = null;
		try {
			memberBasicVO = memberRepository.read(username);
		} catch (Exception e) {
			e.printStackTrace();
		}       
        
		// Role Class 를 이용해 auth 테이블 없이 간단하게 구현하는 방법
		/*
		 * List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		 * 
		 * if (("admin").equals(username)) { authorities.add(new
		 * SimpleGrantedAuthority(RoleEnum.ADMIN.getValue())); } else { authorities.add(new
		 * SimpleGrantedAuthority(RoleEnum.MEMBER.getValue())); }
		 */
        
		MemberVO user = new MemberVO(memberBasicVO);
        System.out.println("loadUserByUsername" + user.getMemberBasicVO().toString());
        
        return user;
    }
    
    // 회원가입
    public int join(MemberBasicVO memberBasicVO, String year, String month, String day) throws Exception{
        
    	// 비밀번호 암호화
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        memberBasicVO.setPassword(passwordEncoder.encode(memberBasicVO.getPassword()));

        // birth, age, fileName 세팅
        memberBasicVO.setBirth(memberInfoMaker.makeBirth(year, month, day));
        memberBasicVO.setAge(memberInfoMaker.makeAge(year));
        memberBasicVO.setFileName("defaultProfile");
        
        
        // db에 저장
        int result = memberRepository.join(memberBasicVO);
        System.out.println(result);

        AuthVO authVO = new AuthVO();
        authVO.setUsername(memberBasicVO.getUsername());
        authVO.setAuth(RoleEnum.MEMBER.getValue());
        result = authRepository.join(authVO);
        
        return result;
    }
    
    // 이미 등록된 id인지 Check
    public MemberBasicVO memberIdCheck(MemberBasicVO memberBasicVO) throws Exception {
    	return memberRepository.memberIdCheck(memberBasicVO);
    }
    
    // 이미 등록된 nick 인지 Check
 	public MemberBasicVO memberNickCheck(MemberBasicVO memberBasicVO) throws Exception{
 		return memberRepository.memberNickCheck(memberBasicVO);
 	}
    
    // 이미 등록된 phone 번호인지 Check
 	public MemberBasicVO phoneCheck(MemberBasicVO memberBasicVO) throws Exception {
 		
 		// 해당되는 유저가 있다면 유저 반환
 		MemberBasicVO findMemberBasicVO = memberRepository.phoneCheck(memberBasicVO);
 		if(findMemberBasicVO != null) {
    		return findMemberBasicVO;
    	}
 		
 		// 해당되는 유저가 없다면, sms 인증 진행
 		// 인증번호 생성, redis에 key : value 형태로 (phone:authCode) 저장 
    	GenerateRandomNumber authMaker = new GenerateRandomNumber();
        //String authCode = authMaker.excuteGenerate();
        String authCode = "137955";
        
        
        // 폰 번호가 없음 -> 인증 메시지 보내기
    	String contents = "[CGV]인증번호는 "+authCode+" 입니다";
    	System.out.println(memberBasicVO.getPhone());
    	System.out.println(contents);
    	//smsSender.smsSend(memberBasicVO.getPhone(), contents);
    	
    	// redis에 set
    	redisTemplate.opsForValue().set(memberBasicVO.getPhone(), authCode);

    	return null;
 	};
 	
 	// 보낸 인증번호와 들어온 인증번호가 같은지 체크
 	public boolean phoneConfirm(MemberBasicVO memberBasicVO, String authCode) {
 		
 		boolean result = false;
 		
 		// redis에 있는 key : value (전화번호 : 인증번호) 불러오기
 		String value = (String)redisTemplate.opsForValue().get(memberBasicVO.getPhone());
        
        // 클라이언트에서 온 authCode와 저장된 authCode가 같다면, 저장된 인증데이터 삭제
        if(value != null || value.equals(authCode)) {
        	redisTemplate.delete(memberBasicVO.getPhone());
        	result = true;
        }
        
 		return result;
 	}
 	
 	// memberList 띄우기
 	public List<MemberBasicVO> memberList(Pager pager) throws Exception {
 		System.out.println("startNum : "+pager.getStartNum());
 		System.out.println("perpage : "+pager.getPerPage());
 		long totalNum = memberRepository.memberCount(pager);
		pager.makeRow();
		pager.makeBlock(totalNum);
 		return memberRepository.memberList(pager);
 	}
 	
 	// member 지우기 (실데이터 삭제 아님)
 	public int memberDelete(MemberBasicVO memberBasicVO) throws Exception {
 		
 		return memberRepository.memberDelete(memberBasicVO);
 	}
 	
 	// member 수정
 	public int memberEdit(MemberBasicVO memberBasicVO, MultipartFile[] files, HttpSession session) throws Exception{
 	
 		MemberBasicVO findMemberVO = (MemberBasicVO)session.getAttribute("memberVO");

 		// 기존 이미지 삭제 (defaultProfile.png가 아니라면) && 이미지가 새로 들어왔다면
 	 	if(!findMemberVO.getFileName().equals("defaultProfile.png") && files.length != 0) {
 	 		
 	 		String delPath = filePath + findMemberVO.getFileName().substring(0, findMemberVO.getFileName().lastIndexOf("/")+1);
 	 		String fileName = findMemberVO.getFileName().substring(11);
 	 		File delFile = filePathGenerator.getUseClassPathResource(delPath);
 	 		int result = fileManager.deleteFile(fileName, delFile);
 	 	}
 		
 		// 파일 저장
 		String path = FilePathGenerator.addTimePath("");
 		String extendPath = FilePathGenerator.addTimePath(filePath);
 		File file = filePathGenerator.getUseClassPathResource(extendPath);
 		System.out.println(session.getServletContext().getRealPath(extendPath));
 		
 		if(files.length>0) {
			
 			// 1번 들어올 for문, multipartFile[] 을 쓰는 이유는 다음번에 참고용으로 사용하기 위함
			for (MultipartFile multipartFile : files) {
				if(!(multipartFile.getSize()>0))
					continue;
				//System.out.println("service syso : "+multipartFile.getInputStream());
				fileManager.onResizeFunction(200);	// 이미지 resize를 하려면 해당 함수를 사용하면 됨 (이미지 파일일때만 실행됨)
				String fileName = fileManager.saveTransfer(multipartFile, file); //이미지 파일 저장
				findMemberVO.setFileName(path+fileName);							
			}
		}
 		
 		// 테이블 수정
 		findMemberVO.setNick(memberBasicVO.getNick());
 		return memberRepository.memberEdit(findMemberVO);
 	}
}
