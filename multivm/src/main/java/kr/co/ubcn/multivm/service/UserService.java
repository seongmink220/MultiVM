package kr.co.ubcn.multivm.service;

import kr.co.ubcn.multivm.controller.ProductController;
import kr.co.ubcn.multivm.mapper.CompanyMapper;
import kr.co.ubcn.multivm.mapper.OrganizationMapper;
import kr.co.ubcn.multivm.mapper.UserMapper;
import kr.co.ubcn.multivm.model.LoginUser;
import kr.co.ubcn.multivm.model.Organization;
import kr.co.ubcn.multivm.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {

    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    UserMapper userMapper;
    @Autowired
    CompanyMapper companyMapper;
    @Autowired
    OrganizationMapper organizationMapper;

    //User-list 회원관리
    //User insert
    //User update
    //User delete > userYN:N
    //

    public Map<String,Object> loginCheck(User user, HttpServletRequest request) {
        //LoginUser login = userMapper.loginUserInfo(user);
        Map<String,Object> paramMap = new HashMap<>();
        User login = userMapper.getOneUserList(user);

        if (login == null) {
            paramMap.put("status","fail");
            paramMap.put("message","로그인 정보가 일치하지 않습니다.");
        } else {
            //System.out.println("로그인 정보 있음 : "+login);

            if(login.getUseYN().equals('N')||login.getUseYN()==null||login.getUseYN().equals("")){
                paramMap.put("status","NoUse");
                paramMap.put("message","비활성화된 계정입니다.");
                return paramMap;
            }
            if(login.getCompanySeq()==null) {
                paramMap.put("status","NoCompany");
                paramMap.put("message","소속/조직 등록이 필요합니다. 관리자에게 문의해주세요.");
                return paramMap;
            }
            if(login.getOrganizationSeq()==null||organizationMapper.getOrganizationInfo(login)==null) {
                paramMap.put("status","NoCompany");
                paramMap.put("message","소속/조직 등록이 필요합니다. 관리자에게 문의해주세요.");
                return paramMap;
            }
            paramMap.put("status","success");
            HttpSession session = request.getSession();
            if(session.getAttribute("loginUser")!=null)session.removeAttribute("loginUser");

            login.setCompanyName(companyMapper.getCompanyName(login.getCompanySeq()));
            Organization organization = organizationMapper.getOrganizationInfo(login);
            login.setOrganizationName(organization.getName());
            //login.setDepth(organization.getDepth());
            //login.setParentSeq(organization.getParentSeq());

            session.setAttribute("loginUser", login);
            session.setAttribute("userSeq", login.getSeq());
            logger.info("세션정보 : {}",session.getAttribute("loginUser"));

            //초기화면 [상품관리 - 전체 상품정보(list)]
        }
        return paramMap;
    }






}
