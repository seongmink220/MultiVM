package kr.co.ubcn.multivm.intercepter;

import kr.co.ubcn.multivm.controller.ProductController;
import kr.co.ubcn.multivm.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthIntercepter implements HandlerInterceptor {
    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        User user = (User)session.getAttribute("loginUser");
        if(user.getAuth()==0||user.getAuth()==1||user.getAuth()==2||user.getAuth()==3){
            //System.out.println("[상품정보복제]권한 허용");
            logger.info("[상품정보복제]권한 허용 |세션정보 : id:{}, companyName:{}, orgName:{}",user.getId(),user.getCompanyName(),user.getOrganizationName());
            return true;
        }else{
            logger.info("[상품정보복제]권한 허용안함 |세션정보 : id:{}, companyName:{}, orgName:{}",user.getId(),user.getCompanyName(),user.getOrganizationName());
            //System.out.println("[상품정보복제]권한 허용안함");
            response.sendRedirect("/product/list");
            return false;
        }
    }
}
