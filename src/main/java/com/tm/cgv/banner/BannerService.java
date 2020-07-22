package com.tm.cgv.banner;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tm.cgv.eventImage.EventImageVO;
import com.tm.cgv.util.FileManager;
import com.tm.cgv.util.FilePathGenerator;

@Service
public class BannerService {

	@Autowired
	private BannerRepository bannerRepository;
	
	@Value("${board.mainBanner.filePath}") //images/banner/
	private String mainFilePath;
	
	@Value("${board.sideBanner.filePath}") 
	private String sideFilePath;
	
	@Autowired
	private FilePathGenerator filePathGenerator;
	
	
	//list
	public List<BannerVO> sideMovieAdList() throws Exception {
		return bannerRepository.selectSideBannerList(0);
	}
	
	public List<BannerVO> sideEventAdList() throws Exception {
		return bannerRepository.selectSideBannerList(1);
	}
	
	//insert
	public int bannerInsert(BannerVO bannerVO, MultipartFile files) throws Exception {
		FilePathGenerator filePathGenerator = new FilePathGenerator();
		String path = FilePathGenerator.addTimePath("");
		System.out.println(path+"path!!!!");
		System.out.println("filePath : " + sideFilePath);
		String extendPath = FilePathGenerator.addTimePath(sideFilePath);
		System.out.println("ExtendPath : " + extendPath);
		File file = filePathGenerator.getUseClassPathResource(extendPath);
		FileManager fileManager = new FileManager();
		System.out.println("file : " + file);
		String fileName = fileManager.saveFileCopy(files, file);
		//저장 끝
		
		bannerVO.setFileName(path+fileName);
		bannerVO.setOriginName(files.getOriginalFilename());
		
		
		return bannerRepository.bannerInsert(bannerVO);
	}
	
	public BannerVO selectBanner(int num) throws Exception {
		return bannerRepository.selectBanner(num);
	}
	
	public int updateBanner(BannerVO bannerVO, MultipartFile files) throws Exception {
		int result = 0;
		
		//bannerVO는 그대로 업데이...음
		BannerVO vo = bannerRepository.selectBanner(bannerVO.getNum());
		if(files != null) {
			//원래 파일은 삭제
			this.fileDelete(vo);
			System.out.println("--끝--");
			
			//새 파일 저장 후
			FilePathGenerator filePathGenerator = new FilePathGenerator();
			String path = FilePathGenerator.addTimePath("")+"\\";
			System.out.println(path+"path!!!!");
			String extendPath = FilePathGenerator.addTimePath(sideFilePath);
			File file = filePathGenerator.getUseClassPathResource(extendPath);
			FileManager fileManager = new FileManager();
			System.out.println("file : " + file);
			String fileName = fileManager.saveFileCopy(files, file);
			//저장 끝
			
			bannerVO.setFileName(path+fileName);
			bannerVO.setOriginName(files.getOriginalFilename());
			
			
			//vo의 내용 업데이트
			result = bannerRepository.updateBanner(bannerVO);
		}else {
			bannerVO.setFileName(vo.getFileName());
			bannerVO.setOriginName(vo.getOriginName());
			result = bannerRepository.updateBanner(bannerVO);
		}
		
		
		
		return result;
	}
	
	public int deleteBanner(int num) throws Exception 	{
		//파일 삭제
		BannerVO bannerVO = bannerRepository.selectBanner(num);
		this.fileDelete(bannerVO);
		
		//테이블 삭제
		return bannerRepository.deleteBanner(num);
	}
	
	public BannerVO selectAdBanner(BannerVO bannerVO) throws Exception 	{
		return bannerRepository.selectAdBanner(bannerVO);
	}
	
	private int fileDelete(BannerVO bannerVO) throws Exception {

		FileManager fileManager = new FileManager();
		
		//HDD삭제
		System.out.println(filePathGenerator);
		System.out.println("........"+sideFilePath);
		File dest = filePathGenerator.getUseClassPathResource(sideFilePath);
		System.out.println("dest : " + dest);
		System.out.println(bannerVO.getFileName());
		int result = fileManager.deleteFile(bannerVO.getFileName(), dest);
		
		
		return result;
	}
	
	

	
	
	
}
