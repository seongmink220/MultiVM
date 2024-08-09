package kr.co.ubcn.multivm.controller;

import kr.co.ubcn.multivm.mapper.OrganizationMapper;
import kr.co.ubcn.multivm.model.LoginUser;
import kr.co.ubcn.multivm.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/test")
public class TestController {

    @Autowired
    OrganizationMapper organizationMapper;

    @GetMapping("")
    public ModelAndView testPage(HttpSession session){
        User login = (User)session.getAttribute("loginUser");
        System.out.println("로그인유저저 : "+login.getName());

        return new ModelAndView("test");

    }
}
