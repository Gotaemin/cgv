package com.tm.cgv.event;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tm.cgv.eventImage.EventImageRepository;
import com.tm.cgv.eventImage.EventImageService;
import com.tm.cgv.eventImage.EventImageVO;
import com.tm.cgv.util.FileManager;
import com.tm.cgv.util.FilePathGenerator;
import com.tm.cgv.util.Pager_eventList;

@Service
public class EventService {
	
	@Autowired
	private EventRepository eventRepository;
	
	@Autowired
	private EventImageRepository eventImageRepository;
	
	@Value("${board.event.filePath}")
	private String filePath;
	
	@Autowired
	private FilePathGenerator filePathGenerator;
	
	@Autowired
	private EventImageService eventImageService;
	
	
	
	
	public List<EventVO> adminEventList(Pager_eventList pager) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		pager.makeRow();
		long totalCount = eventRepository.adminEventCount(pager);
		pager.makeBlock(totalCount);
		List<EventVO> list = eventRepository.adminEventList(pager);
		
		return list;
	}

	
	public List<EventVO> eventList(Pager_eventList pager) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		pager.makeRow();
		long totalCount = eventRepository.eventCount(pager);
		pager.makeBlock(totalCount);
		List<EventVO> list = eventRepository.eventList(pager);

		return list;
	}
	
	public List<EventVO> endEventList(Pager_eventList pager) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		pager.makeRow();
		long totalCount = eventRepository.endEventCount(pager);
		pager.makeBlock(totalCount);
		List<EventVO> list = eventRepository.endEventList(pager);
		
		return list;
	}
	

	@Transactional
	public int eventInsert(EventVO eventVO, List<MultipartFile> files) throws Exception {
		//받아온 EventVO Event table에 삽입
		int result = eventRepository.eventInsert(eventVO);
		
		//EventImage에 들어갈 정보 만들기
		FilePathGenerator filePathGenerator = new FilePathGenerator();
		String path = FilePathGenerator.addTimePath("")+"\\";
	    System.out.println(path+"path!!!!");
	    String extendPath = FilePathGenerator.addTimePath(filePath);
	    File file = filePathGenerator.getUseClassPathResource(extendPath);
		FileManager fileManager = new FileManager();
		EventImageVO eventImageVO = new EventImageVO();

		if(files.size()==0) {
    		return 0;
    	}
		
		//첫번째 파일 저장
		MultipartFile tmp = files.remove(0);
		eventImageVO.setEventNum(eventVO.getNum());
    	String fileName = fileManager.saveFileCopy(tmp, file);
    	eventImageVO.setType(0);
    	eventImageVO.setFileName(path+fileName);
    	eventImageVO.setOriginName(tmp.getOriginalFilename());
	    eventImageRepository.insertImage(eventImageVO);
	    
	    //두번째 파일 저장
	    fileName = fileManager.saveFileCopy(files.get(0), file);
	    eventImageVO.setType(1);
    	eventImageVO.setFileName(path+fileName);
    	eventImageVO.setOriginName(files.get(0).getOriginalFilename());
	    eventImageRepository.insertImage(eventImageVO);
	    
	    //eventNum 받아오기
	    //type 거르기
		return result;
	}
	
	private EventImageVO selectImage(int num) throws Exception {
		System.out.println("num : " + num);
		return eventImageRepository.selectImage(num);
	}
	
	private int fileDelete(EventImageVO eventImageVO) throws Exception {

		FileManager fileManager = new FileManager();
		filePath = "images/event/eventList/eventImage/";

		
		//HDD삭제
		System.out.println(filePathGenerator);
		System.out.println("........"+filePath);
		
		File dest = filePathGenerator.getUseClassPathResource(filePath);
		System.out.println("dest : " + dest);
		System.out.println(eventImageVO.getFileName());
		int result = fileManager.deleteFile(eventImageVO.getFileName(), dest);
		
		
		return result;
	}
	
	
	public EventVO eventSelect(int num) throws Exception {
		return eventRepository.eventSelect(num);
	}
	
	public int eventUpdate(EventVO eventVO, List<MultipartFile> files, String [] delNum) throws Exception {
		
		System.out.println("service");
		System.out.println(eventVO.getTitle());
		System.out.println(eventVO.getNum());
		int result = eventRepository.eventUpdate(eventVO); //event table update
		
		
		//이벤트 테이블은 그대로 업데이트
		//받아온 delNum을 읽은 후
		//일단 그것들의 파일을 삭제 후 다시 삽입 > 테이블까지 업데이트

		//두 개 다 삭제 후 다시 삽입 > 그대로 
		//하나만 삭제 후 다시 삽입 > 받아온 delNum으로 그거만 삭제 후 넣기
		
		FilePathGenerator filePathGenerator = new FilePathGenerator();
		String path = FilePathGenerator.addTimePath("");
	    System.out.println(path+"path!!!!");
	    String extendPath = FilePathGenerator.addTimePath(filePath);
	    File file = filePathGenerator.getUseClassPathResource(extendPath);
		FileManager fileManager = new FileManager();
		EventImageVO eventImageVO = new EventImageVO();
		
		//
		
		
		if(files.size()==2) {
			//두 사진 모두 변경했을 경우
			//첫번째 파일 저장
			System.out.println("파일 2개 변경시");
			EventImageVO vo = this.selectImage(Integer.parseInt(delNum[0]));
			this.fileDelete(vo);  //기존의 파일 삭제
			
			
			MultipartFile tmp = files.remove(0);
			
			eventImageVO.setEventNum(eventVO.getNum());
	    	String fileName = fileManager.saveFileCopy(tmp, file);	//다시 저장
	    	eventImageVO.setNum(Integer.parseInt(delNum[0]));
	    	eventImageVO.setFileName(path+fileName);
	    	eventImageVO.setOriginName(tmp.getOriginalFilename());
	    	
	    	System.out.println("새 파일 네임 : " + eventImageVO.getFileName());
		    eventImageRepository.updateImage(eventImageVO);	//테이블 업데이트
		    
		    //두번째 파일 저장
			vo = this.selectImage(Integer.parseInt(delNum[1]));
			this.fileDelete(vo);  //기존의 파일 삭제
			
		    fileName = fileManager.saveFileCopy(files.get(0), file);	//다시 저장
		    
		    eventImageVO.setNum(Integer.parseInt(delNum[1]));
	    	eventImageVO.setFileName(path+fileName);
	    	eventImageVO.setOriginName(files.get(0).getOriginalFilename());
	    	
	    	eventImageRepository.updateImage(eventImageVO);	//테이블 업데이트
		    
		    
		    
		}else if(files.size()==1) {
			//이미지 하나만 바뀐 경우
			System.out.println("파일 1개 변경시");
			
			EventImageVO vo = this.selectImage(Integer.parseInt(delNum[0]));
			this.fileDelete(vo);  //기존의 파일 삭제
			
			String fileName = fileManager.saveFileCopy(files.get(0), file);
			eventImageVO.setNum(Integer.parseInt(delNum[0]));
	    	eventImageVO.setFileName(path+fileName);
	    	eventImageVO.setOriginName(files.get(0).getOriginalFilename());
	    	
	    	System.out.println("변경하는 이미지 넘 : " + Integer.parseInt(delNum[0]));
	    	System.out.println("새 파일 네임 : " + eventImageVO.getFileName());
	    	eventImageRepository.updateImage(eventImageVO);	//테이블 업데이트
		}
		
		return result;
	}
	
	
	
	public int eventDelete(int num) throws Exception {
		return eventRepository.eventDelete(num);
		
	}
	
	public EventVO eventSelect2(int num) throws Exception {
		return eventRepository.eventSelect2(num);
	}
	
}
