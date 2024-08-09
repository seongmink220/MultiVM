package kr.co.ubcn.multivm.controller;


import kr.co.ubcn.multivm.model.Product;
import kr.co.ubcn.multivm.model.User;
import kr.co.ubcn.multivm.service.CustomerService;
import kr.co.ubcn.multivm.service.HomeService;
import kr.co.ubcn.multivm.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping(value = "")
public class HomeController {

    Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired
    HomeService homeService;
    @Autowired
    CustomerService customerService;
    @Autowired
    ProductService productService;

    @GetMapping("/")
    public ModelAndView root(HttpServletRequest request, HttpSession session) throws Exception {//, @CookieValue("cookie") String cookie){
        ModelAndView mav = new ModelAndView();
        User loginUser = (User)session.getAttribute("loginUser");
        if(loginUser==null){
            mav.setViewName("login");
            return mav;
        }
        return homeService.setIndexPage(mav, request);
    }

    @GetMapping("/login")
    public ModelAndView login(HttpSession session){
        ModelAndView mav = new ModelAndView();
        session.invalidate();
        mav.setViewName("login");
        return mav;
    }

    @PostMapping("/login")
    public Map<String,Object> pro_login(User user
            , HttpServletRequest request){
        return homeService.loginCheck(user, request);
    }

    @GetMapping("/logout")
    public ModelAndView logout(HttpSession session,HttpServletRequest request){
        session.invalidate();
        return new ModelAndView("redirect:login");
    }

    @GetMapping("/index")
    public ModelAndView index(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        return homeService.setIndexPage(mav, request);
    }

    @GetMapping("/error")
    public ModelAndView error(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("error/404");
        return mav;
    }
    @GetMapping("/imageModal")
    public ModelAndView imageModal(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("imageModal");
        return mav;
    }
    @GetMapping("/detail")
    public void ckeditorDetail(@RequestParam(value="uid") String uid
            , @RequestParam(value="fileName") String fileName
            , HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        customerService.setSubmitFile(uid,fileName,response);
    }

    @GetMapping("/notice")
    public void fileDn_notice(@RequestParam(value="file") String fileName
            , HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        customerService.downloadFile(fileName,response);
    }
    @RequestMapping("popup/imageSearch")
    public ModelAndView getPopupView(HttpServletRequest request, Product product, ModelAndView mav) throws Exception {
        mav.setViewName("imageListView");
        mav.addObject("data",productService.getProductImageList(product));
        return mav;
    }


}
