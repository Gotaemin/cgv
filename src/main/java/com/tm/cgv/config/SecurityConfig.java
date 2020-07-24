package com.tm.cgv.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.tm.cgv.member.MemberService;
import com.tm.cgv.rememberMe.RememberMeTokenRepository;
import com.tm.cgv.security.CustomLoginFailureHandler;
import com.tm.cgv.security.CustomLoginSuccessHandler;
import com.tm.cgv.security.CustomLogoutHandler;
import com.tm.cgv.security.CustomRememberMeLoginSuccessHandler;


@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CustomLoginSuccessHandler loginSuccessHandler;
	
	@Autowired
	private CustomLoginFailureHandler loginFailureHandler;
	
	@Autowired
	private CustomLogoutHandler logoutHandler;

	@Autowired
	private CustomRememberMeLoginSuccessHandler rememberMeLoginSuccessHandler;
	
	@Autowired
	private RememberMeTokenRepository persistentTokenRepository;
	
	// 암호화 모듈
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
 //    중복 로그인 제한을 위해 필요
    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }// Register HttpSessionEventPublisher

    // 중복 로그인 제한을 위해 필요
//    @Bean
//    public static ServletListenerRegistrationBean httpSessionEventPublisher() {
//        return new ServletListenerRegistrationBean(new HttpSessionEventPublisher());
//    }
//    
    @Bean
	public PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices() {
	    PersistentTokenBasedRememberMeServices persistenceTokenBasedservice = new PersistentTokenBasedRememberMeServices("cgvProject", memberService, persistentTokenRepository);
	    persistenceTokenBasedservice.setParameter("auto-login");
	    persistenceTokenBasedservice.setAlwaysRemember(false);
	    persistenceTokenBasedservice.setCookieName("remember-me");
	    persistenceTokenBasedservice.setTokenValiditySeconds(60 * 60 * 24 * 7);		// 토큰 유효시간 1주일 설정
	    return persistenceTokenBasedservice;
	  }
    
    @Override
    public void configure(WebSecurity web) throws Exception
    {
        // static 디렉터리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
        web.ignoring().antMatchers("/css/**", "/js/**", "/images/**", "/font/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        
    	http.authorizeRequests()
                // 페이지 권한 설정 (순서 위에서 아래로, 제한할 경로를 위로, 제한 없는 경로를 아래로)
        		.antMatchers("/admin/**").hasRole("ADMIN")
        		.antMatchers("/member/myPage").hasRole("MEMBER")
        		.antMatchers("/member/edit").hasRole("MEMBER")
        		.antMatchers("/member/memberDelete").hasRole("MEMBER")
        		.antMatchers("/review/reviewList").hasRole("MEMBER")
        		.antMatchers("/review/getList").hasRole("MEMBER")
        		.antMatchers("/review/review_Write1").hasRole("MEMBER")
        		.antMatchers("/review/review_Write2").hasRole("MEMBER")
        		.antMatchers("/review/review_Select").hasRole("MEMBER")
        		.antMatchers("/review/review_Delete").hasRole("MEMBER")
        		.antMatchers("/review/reviewLook").hasRole("MEMBER")
        		.antMatchers("/review/review_Update1").hasRole("MEMBER")
        		.antMatchers("/review/review_Update2").hasRole("MEMBER")
        		.antMatchers("/review/reviewLike").hasRole("MEMBER")
        		.antMatchers("/review/reviewSpoiler").hasRole("MEMBER")
        		.antMatchers("/review/reviewSwearWord").hasRole("MEMBER")
        		.antMatchers("/review/review_Modal").hasRole("MEMBER")
        		.antMatchers("/review/movieSelect_reviewUpdate").hasRole("MEMBER")
        		.antMatchers("/review/movieSelect_reviewWrite").hasRole("MEMBER")
        		.antMatchers("/review/reviewDiary").hasRole("MEMBER")
        		.antMatchers("/review/reviewDiary_Write").hasRole("MEMBER")
        		.antMatchers("/review/reviewDiary_Delete").hasRole("MEMBER")
        		.antMatchers("/**").permitAll();
    	
    	// 로그인 설정
    	http.formLogin()
                .loginPage("/member/login")
                .successHandler(loginSuccessHandler)
                .failureHandler(loginFailureHandler);
                //.defaultSuccessUrl("/")	// successHandler를 안쓸거면 사용
                //.permitAll()
        
        // 로그아웃 설정 (핸들러 있어야 session 지워짐(아무것도 수행안해도 그런듯))
        http.logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/member/logout"))	// 이 경로로 접근하면 로그아웃을 처리해줌
                .addLogoutHandler(logoutHandler)									// 로그아웃 핸들러
                .logoutSuccessUrl("/member/logoutSuccess")							// controller내의 결과 경로 매핑
                .invalidateHttpSession(true);										// 세션 해제;
                //.deleteCookies("remember-me","JSESSIONID");						// 쿠키 삭제 (remember-me는 spring, JSESSIONID는 tomcat에서 발행)
        
        // 403 예외처리 핸들링
        http.exceptionHandling().accessDeniedPage("/member/denied");
        
        // 중복 접속 제한
//        http.sessionManagement()
//        	.maximumSessions(1)
//        	.maxSessionsPreventsLogin(true)
//        	.expiredUrl("/duplicated-login")
//            .sessionRegistry(sessionRegistry());
    
        http.rememberMe()
        	.key("cgvProject")								// rememberMe 인증을 위해 발행되는 토큰을 구별하는 키이름
        	.tokenValiditySeconds(60 * 60 * 24 * 7)			// 기본 토큰 유효시간 설정(초) - 별도로 설정안하면 기본 2주간 유효
        	.rememberMeParameter("auto-login")				// 로그인 페이지에서 html (input 태그) 자동로그인 파라미터 이름(name 값)
        	.rememberMeCookieName("remember-me")			// 쿠키이름 설정;
        	.tokenRepository(persistentTokenRepository)		// DB의 token 테이블과 연결된 repository 연결
        	.userDetailsService(memberService)				// remember-me를 이용한 로그인을 하기위해 userDetailService 구현체와 연결?
        	.rememberMeServices(persistentTokenBasedRememberMeServices())
        	.authenticationSuccessHandler(rememberMeLoginSuccessHandler);
        	//.useSecureCookie(true);							// http 요청 쿠키 사용
    }

    // 로그인시, memberService.loadUserByUsername로 member인증 진행, return User type
    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
    	auth.userDetailsService(memberService).passwordEncoder(passwordEncoder());
    }
}
