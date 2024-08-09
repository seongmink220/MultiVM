package kr.co.ubcn.multivm.service;

import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class BoardService {
    @Autowired
    UserMapper userMapper;
    @Autowired
    CompanyMapper companyMapper;
    @Autowired
    OrganizationMapper organizationMapper;
    @Autowired
    VendingMachineMapper vendingMachineMapper;
    @Autowired
    ReleaseMapper releaseMapper;
    @Autowired
    StoreMapper storeMapper;
    @Autowired
    StockMapper stockMapper;

    public ModelAndView setBoardPage(ModelAndView mav, HttpServletRequest request, String page){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");

        SimpleDateFormat format = new SimpleDateFormat ( "yyyyMMdd");
        Calendar time = Calendar.getInstance();
        String today = format.format(time.getTime());

        Map<String, Object> map = new HashMap<>();
        if(user.getAuth()!=0){
            map.put("companySeq",user.getCompanySeq());
        }
        if(user.getAuth()==3) {
            map.put("organizationSeq", user.getOrganizationSeq());
        }
        if(user.getAuth()==4){
            map.put("auth",4);
            map.put("userSeq",user.getSeq());
        }
        List<Organization> orgList = organizationMapper.getOrganizationList(map);
        mav.addObject("companyList",companyMapper.getAllCompanyList())
                .addObject("orgList",orgList);

        if(user.getAuth()==4){
            map.put("organizationSeq",orgList.get(0).getSeq());
        }
        mav.addObject("vmList",vendingMachineMapper.getSearchVM2(map));

        map.put("sDate", today);
        map.put("eDate", today);

        if(user.getAuth()!=0){
            map.put("organizationSeq",orgList.get(0).getSeq());
        } //전체를 보여주긴 너무 많으니까 첫번째 조직 자동선택

        switch (page){
            case "store":
                mav.addObject("storeList",user.getAuth()==0?null:storeMapper.getStoreList(map))
                        .setViewName("board/store");
                break;
            case "release" :
                mav.addObject("releaseList",user.getAuth()==0?null:releaseMapper.getReleaseList(map))
                        .setViewName("board/release");
                break;
            case "stock" :
                mav.addObject("stockList",user.getAuth()==0?null:stockMapper.getStockList(map))
                        .setViewName("board/stock");
                break;
            default:
        }

        return mav;
    }

}
