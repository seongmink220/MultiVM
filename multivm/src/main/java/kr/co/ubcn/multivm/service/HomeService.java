package kr.co.ubcn.multivm.service;

import kr.co.ubcn.multivm.controller.ProductController;
import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.Organization;
import kr.co.ubcn.multivm.model.Sales;
import kr.co.ubcn.multivm.model.User;
import kr.co.ubcn.multivm.model.VendingMachine;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class HomeService {
    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    UserMapper userMapper;
    @Autowired
    CompanyMapper companyMapper;
    @Autowired
    OrganizationMapper organizationMapper;
    @Autowired
    VendingMachineMapper vendingMachineMapper;
    @Autowired
    SalesMapper salesMapper;
    @Autowired
    NoticeMapper noticeMapper;


    public Map<String,Object> loginCheck(User user, HttpServletRequest request) {
        Map<String,Object> paramMap = new HashMap<>();
        User login = userMapper.getOneUserList(user);

        if (login == null) {
            paramMap.put("status","fail");
            paramMap.put("message","로그인 정보가 일치하지 않습니다.");
        } else {
            if(login.getUseYN().equals("N")||login.getUseYN()==null||login.getUseYN().equals("")){
                paramMap.put("status","NoUse");
                paramMap.put("message","비활성화된 계정입니다.");
                return paramMap;
            }
            // 2022.11.23 조직 필수조건 제거
            /*else if(login.getOrganizationSeq()==null||organizationMapper.getOrganizationInfo(login)==null) {
                paramMap.put("status","NoCompany");
                paramMap.put("message","소속/조직 등록이 필요합니다. 관리자에게 문의해주세요.");
                return paramMap;
            }*/
            else{
                paramMap.put("status","success");
                paramMap.put("message","success");

                HttpSession session = request.getSession();
                if(session.getAttribute("loginUser")!=null)session.removeAttribute("loginUser");

                login.setCompanyName(companyMapper.getCompanyName(login.getCompanySeq()));
                if(login.getOrganizationSeq()!=null) {
                    Organization organization = organizationMapper.getOrganizationInfo(login);
                    login.setOrganizationName(organization.getName());
                }

                session.setAttribute("loginUser", login);
                session.setAttribute("userSeq", login.getSeq());

                logger.info("로그인성공 : {}",session.getAttribute("loginUser"));
            }
        }
        return paramMap;
    }

    public ModelAndView setIndexPage(ModelAndView mav, HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        String today = sdf.format(date);

        //어제 날짜
        date = new Date(date.getTime()+(1000*60*60*24*-1));
        SimpleDateFormat ysdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        String yesterday =sdf.format(date);

        Map<String, Object> map2 = new HashMap<>();
        map2.put("companySeq",user.getCompanySeq());

        if(user.getAuth()!=0&&user.getAuth()!=1){
            map2.put("organizationSeq",user.getOrganizationSeq());
        }
        if(user.getAuth()==4){
            map2.put("auth", 4);
            map2.put("userSeq", user.getSeq());
        }
        map2.put("index", "index");

        List<VendingMachine> vmList = vendingMachineMapper.getSearchVM(map2);
        Sales sales = new Sales();
        sales.setCompanySeq(user.companySeq);
        sales.setTransactionDate(today);
        if(user.getAuth()!=0&&user.getAuth()!=1){
            sales.setOrganizationSeq(user.organizationSeq);
            if(!vmList.isEmpty()) {
                sales.setVmId(vmList.get(0).vmId);
                sales.setTerminalId(vmList.get(0).terminalId);
            }
            if(user.getAuth()==4){
                sales.setUserSeq(user.getSeq());
            }
        }

        Sales tmp = new Sales();
        tmp.setCompanySeq(sales.getCompanySeq());
        tmp.setOrganizationSeq(sales.getOrganizationSeq());
        tmp.setVmId(sales.getVmId());
        tmp.setTransactionDate(yesterday);
        if(user.getAuth()==4){
            tmp.setUserSeq(user.getSeq());
        }

        //System.out.println("확인22 : "+salesMapper.getIndexWeeklyAmount(sales));
        List<Sales> weeklyAmount = salesMapper.getIndexWeeklyAmount(sales);
        JSONObject xAxis = getxAxisDate(weeklyAmount);
        //JSONArray series = getSeriesData(weeklyAmount);
        JSONArray series = getSeriesData2(weeklyAmount);
        //System.out.println("//xAxis 확인 : "+xAxis);
        //System.out.println("//series 확인 : "+series);
        //System.out.println("setIndexPage 확인 : "+map2);
        //System.out.println("map 확인222 : "+noticeMapper.getNoticeList(map2));

        mav.addObject("salesList",salesMapper.getIndexSalesList(sales))
                .addObject("todayAmount",salesMapper.getIndexAmount(sales))
                .addObject("yesterdayAmount",salesMapper.getIndexAmount(tmp))
                .addObject("xAxis",xAxis)
                .addObject("series",series)
                .addObject("noticeList",noticeMapper.getNoticeList(map2))
                .setViewName("index");

        return mav;
    }

    public JSONObject getxAxisDate(List<Sales> salesList) throws Exception {
        ArrayList<String> xAxisValueDate = new ArrayList<String>();
        JSONObject returnJsonObj = new JSONObject();

        for (int i = 0; i < salesList.size(); i++) {
            if(salesList.get(i).getTransactionDate()!=null)
                xAxisValueDate.add(salesList.get(i).getTransactionDate());
            else
                xAxisValueDate.add(salesList.get(i).getTransactionDate());
        }
        returnJsonObj.put("categories", xAxisValueDate);

        return returnJsonObj;
    }

    public JSONArray getSeriesData(List<Sales> salesList){
        JSONArray returnJsonArray = new JSONArray();
        for (int i = 0; i < salesList.size(); i++) {
            if(salesList.get(i).getAmount()!=null)
                returnJsonArray.add(salesList.get(i).getAmount());
            else
                returnJsonArray.add(salesList.get(i).getAmount());
        }
        return returnJsonArray;
    }

    public JSONArray getSeriesData2(List<Sales> salesList){
        JSONArray returnJsonArray = new JSONArray();
        for (int i = 0; i < salesList.size(); i++) {
            JSONObject jsonObject = new JSONObject();
            if(salesList.get(i).getAmount()!=null) {
                //jsonObject.put("x", salesList.get(i).getTransactionDate());
                jsonObject.put("y", salesList.get(i).getAmount());
                jsonObject.put("itemCount", salesList.get(i).getItemCount());
            }else {
                //jsonObject.put("x", salesList.get(i).getTransactionDate());
                jsonObject.put("y", salesList.get(i).getAmount());
                jsonObject.put("itemCount", salesList.get(i).getItemCount());
            }
            returnJsonArray.add(jsonObject);

        }


        return returnJsonArray;
    }







}
