package com.tm.cgv.movieTime;

import org.json.JSONException;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MovieTimeTest {
 
    //@Test
    public void movieTimeTest() throws JSONException {
        
    	String time = "01:11";
    	String[] separatedTime = time.split(":");
    	System.out.println(separatedTime[0]+" "+separatedTime[1]);
    	
    	int hour = Integer.parseInt(separatedTime[0]);
    	if(0 <= hour && hour <= 2) {
    		hour += 24;
    	}
    	
    	time = hour +":"+ separatedTime[1];
    	System.out.println(time);
    }
}
