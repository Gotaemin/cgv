package com.tm.cgv.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

	private String loginidname;
    private String loginpwdname;
    private String errormsgname;
    private String defaultFailureUrl;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		String errormsg = null;

		/*
		 * spring security 예외 코드
		 *  
		 * BadCredentialException // 비밀번호가 일치하지 않을 때 던지는 예외		 *   
		 * InternalAuthenticationServiceException // 존재하지 않는 아이디일 때 던지는 예외
		 * AuthenticationCredentialNotFoundException // 인증 요구가 거부됐을 때 던지는 예외
	  	 * LockedException // 인증 거부 - 잠긴 계정
		 * DisabledException // 인증 거부 - 계정 비활성화
		 * AccountExpiredException // 인증 거부 - 계정 유효기간 만료
		 * CredentialExpiredException	// 인증 거부 - 비밀번호 유효기간 만료 
		 */
		
        if(exception instanceof BadCredentialsException || exception instanceof InternalAuthenticationServiceException) {
            errormsg = "아이디가 존재하지 않거나 비밀번호가 일치하지 않습니다";
        }
        
        request.setAttribute("msg", errormsg);
        request.setAttribute("path", "/");
 
        System.out.println("username : "+request.getParameter("username"));
		System.out.println("password : "+request.getParameter("password"));
		System.out.println("errormsg : "+errormsg);
		System.out.println(exception.getMessage());
		
        // result.jsp 보내서 alert 띄우고 다시 login page
        request.getRequestDispatcher("../WEB-INF/views/common/result.jsp").forward(request, response);
	}
}
