package kr.co.ubcn.multivm.intercepter;

import kr.co.ubcn.multivm.model.LoginUser;
import lombok.extern.java.Log;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

public class LoginCheckIntercepter implements HandlerInterceptor {

    /*@Lazy
    @Resource
    LoginUser loginUser;
*/
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        if(session ==null||session.getAttribute("loginUser")==null){
            //if((LoginUser)request.getSession().getAttribute("loginUser")==null){
            System.out.println("로그인 필요");
            response.sendRedirect(request.getContextPath()+"/login");
            return false;
        }else{
            return true;
        }
        //https://jaimemin.tistory.com/1887


        //return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    /*@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HttpSession session = request.getSession();
        if(session.getAttribute("loginUser")!=null){
            if(request.getParameter("useCookie")!=null){
                System.out.println("쿠키쿠키");
                try {
                    Cookie cookie = new Cookie("cookie1",URLEncoder.encode("multiVM", "UTF-8"));
                    cookie.setMaxAge(365*24*60*60);
                    response.addCookie(cookie);
                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        }

        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }*/
}
