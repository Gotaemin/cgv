package com.tm.cgv.utils;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.tm.cgv.util.FilePathGenerator;

@SpringBootTest
class UtilsTest {

	@Test
	void test() throws Exception{
		String filePath = "testPath/test";
		String path = FilePathGenerator.addTimePath("");
		System.out.println(path+"path!!!!");
		String extendPath = FilePathGenerator.addTimePath(filePath);
	}
}
