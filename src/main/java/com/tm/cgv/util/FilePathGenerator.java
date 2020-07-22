package com.tm.cgv.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Component;


@Component
public class FilePathGenerator {

	@Autowired
	private ResourceLoader resourceLoader;
	
	@Autowired
	private ServletContext servletContext;
	
	//배포경로에 저장됨 // maven clean을 하기 전까지는 저장되어 있음
	//	 /static/upload/notice
	//	 /static/upload/qna
	public File getUserResourceLoader(String path) throws Exception{
		//ResourceLoader
		//classes경로를 받아오기 위해서 사용
		//생성하려는 디렉토리가 없으면 에러를 발생
		//Default로 만들어진 static폴더를 이용해서 File객체를 생성하고
		//하위 디렉토리를 Child(자식)으로 사용해서  디렉토리 생성
		
		String defaultPath = "classpath:/static/";
		
		File file = resourceLoader.getResource(defaultPath).getFile();
		file = new File(file, path);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		System.out.println(file.getAbsolutePath());
		return file;
	}
	
	public File getUseClassPathResource(String path) throws Exception{
		//ClassPathResource
		//classes 경로를 받아 오기 위해서 사용
		//ResourceLoader와 같지만 
		//시작 경로에 classpath를 작성하지 않는 점이 다르다(나머지는 동일)
		//대신에 개발자가 직접 객체를 생성하는 방식으로 만들어야 한다(ex.new 를 작성해야한다.)
		
		String defaultPath = "static";
		ClassPathResource cpr = new ClassPathResource(defaultPath);//직접선언해 줘야됨(autowried불가능)
		
		File file = cpr.getFile();
		file = new File(file, path);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		System.out.println(file.getAbsolutePath());
		return file;
	}
	
	//기존의 레거시와 같이 저장(webapp 하위에 생성됨)
	public File getUseServletContext(String path) throws Exception{
		//Servlet Context
		//classpath가 아닌 webapp 하위에 만들어짐
		//생성할 디렉토리가 static이라면
		//webapp 하위에 static폴더가 하나 더 만들어짐
		
		path = servletContext.getRealPath(path);
		File file = new File(path);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		System.out.println(file.getAbsolutePath());
		return file;
	}

	public static String addTimePath(String filePath) throws Exception{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
		String extendPath = sdf.format(new Date());
		//return filePath + extendPath.replace("-", File.separator);	
		return filePath + extendPath;
	}
}




















