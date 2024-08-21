package kr.co.ubcn.multivm.controller;

import com.sun.org.apache.xpath.internal.operations.Or;
import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import kr.co.ubcn.multivm.service.CompanyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/company")
public class CompanyController {

    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    CompanyService companyService;
    @Autowired
    UserMapper userMapper;
    @Autowired
    CompanyMapper companyMapper;
    @Autowired
    OrganizationMapper organizationMapper;
    @Autowired
    VendingMachineMapper vendingMachineMapper;
    @Autowired
    AdvMapper advMapper;
    @Autowired
    EventMapper eventMapper;
    @Autowired
    VendingMachineProductMapper vendingMachineProductMapper;

    @GetMapping("/vending-machine")
    public ModelAndView companyVM(ModelAndView mav, HttpServletRequest request){
        return companyService.setCompanyPage(mav, request, "vm");
    }
    @GetMapping("/user")
    public ModelAndView companyUser(ModelAndView mav, HttpServletRequest request){
        return companyService.setCompanyPage(mav, request, "user");
    }
    @GetMapping("/orig")
    public ModelAndView companyOrig(ModelAndView mav, HttpServletRequest request){
        return companyService.setCompanyPage(mav, request, "orig");
    }
    @GetMapping("/register")
    public ModelAndView companyRegister(ModelAndView mav, HttpServletRequest request){
        return companyService.setCompanyPage(mav, request, "register");
    }
    @GetMapping("/adv")
    public ModelAndView companyAdv(ModelAndView mav, HttpServletRequest request){
        return companyService.setCompanyPage(mav, request, "adv");
    }
    @GetMapping("/event")
    public ModelAndView companyEvent(ModelAndView mav, HttpServletRequest request){
        return companyService.setCompanyPage(mav, request, "event");
    }



    @PostMapping("/ajax/selectCompany.do")
    public Map<String,Object> ajaxSelectCompany(HttpServletRequest request, User user){
        HttpSession session = request.getSession();
        User loginUser = (User)session.getAttribute("loginUser");
        if(loginUser.getAuth()==3){
            user.setOrganizationSeq(loginUser.getOrganizationSeq());
        }
        return companyService.getOrigAndVMList(request, user);
    }
    @PostMapping("/ajax/selectOrig.do")
    public List<VendingMachine> ajaxSelectOrig(@RequestParam Map<String, Object> param, HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");
        if(param.get("organizationSeq").equals("all")){
            param.put("organizationSeq",null);
        }
        if(user.getAuth()==4){
            param.put("auth",4);
            param.put("userSeq",user.getSeq());
        }
        // 조직 select 선택시
        return vendingMachineMapper.getSearchVM(param);
    }

    @PostMapping("/ajax/selectVMList.do")
    public List<VendingMachine> ajaxSelectVMList(VendingMachine vendingMachine){
        //System.out.println("ㅁㅁㅁ "+vendingMachine);
        if(vendingMachine.getOrganizationSeq()!=null&&vendingMachine.getOrganizationSeq()==0){//all
            vendingMachine.setOrganizationSeq(null);
        }
        if(vendingMachine.getSeq()==null||vendingMachine.getSeq()==0){
            vendingMachine.setSeq(null);
        }
        //System.out.println("selectVMList - map: "+vendingMachine);
        //System.out.println("ajaxSelectVMList 컨트롤러 : "+vendingMachineMapper.getSearchVMList(vendingMachine));
        return vendingMachineMapper.getSearchVMList(vendingMachine);
    }
    @Transactional
    @GetMapping("/ajax/selectVMInfo.do")
    public Map<String,Object> ajaxSelectVMInfo(@RequestParam int vmSeq, @RequestParam Map<String, Object> param, HttpSession session, User user){
        Map<String, Object> responseMap = new HashMap<>();
        Map<String, Object> map = new HashMap<>();
        User loginUser = (User)session.getAttribute("loginUser");

        map.put("vmSeq",vmSeq);
        VendingMachine vmInfo = vendingMachineMapper.getUserVM(param);
        user.setCompanySeq(vmInfo.getCompanySeq());
        user.setOrganizationSeq(loginUser.getAuth()==3?vmInfo.getOrganizationSeq():null);

        responseMap.put("comList",companyMapper.getAllCompanyList());
        responseMap.put("orgList",organizationMapper.getOrgOfComList(param));
        responseMap.put("userList",userMapper.getCompanyAllUserList(user));
        responseMap.put("vmInfo",vmInfo);
        return responseMap;
    }

    @GetMapping("/ajax/deleteSelectedVM.do")
    public String ajaxDeleteSelectedVM(@RequestParam(value="deleteList[]") List<Integer> deleteList){
        return companyService.deleteVMList(deleteList);
    }

    @PostMapping("/ajax/insModVMInfo.do")
    public String ajaxInsModVMInfo(VendingMachine vendingMachine
            , HttpServletRequest request){
        return companyService.insertAndModifyVM(vendingMachine,request);
    }

    @GetMapping("/ajax/selectOrgInfo.do")
    public Organization ajaxSelectOrgInfo(User user){
        return organizationMapper.getOrganizationInfo(user);
    }

    @GetMapping("/ajax/selectCompanyInfo.do")
    public Company ajaxSelectCompanyInfo(User user){
        //System.out.println("selectCompanyInfo 컨트롤러 : "+user);
        //System.out.println("확인2 : "+companyMapper.getCompanyInfo(user.getCompanySeq()));
        return companyMapper.getCompanyInfo(user.getCompanySeq());
    }

    @GetMapping("/ajax/deleteSelectedOrg.do")
    public String ajaxDeleteSelectedOrg(@RequestParam(value="deleteList[]") List<Integer> deleteList
            , HttpServletRequest request){
        return companyService.deleteOrgList(deleteList, request);
    }
    @GetMapping("/ajax/deleteSelectedCompany.do")
    public String ajaxDeleteSelectedCompany(@RequestParam(value="deleteList[]") List<Integer> deleteList){
        return companyService.deleteCompanyList(deleteList);
    }
    @PostMapping("/ajax/insModOrgInfo.do")
    public String ajaxInsModOrgInfo(Organization organization
            , HttpServletRequest request){
        return companyService.insertAndModifyOrg(organization,request);
    }

    @PostMapping("/ajax/insModCompanyInfo.do")
    public String ajaxInsModCompanyInfo(Company company
            , HttpServletRequest request){
        return companyService.insertAndModifyCompany(company,request);
    }

    @PostMapping("/ajax/getSelectorOrg.do")
    public List<Organization> ajaxGetSelectorOrg(User user, @RequestParam Map<String, Object> param){
        System.out.println("/getSelectorOrg.do: "+param);
        System.out.println("결과: "+organizationMapper.getOrganizationList(param));
        return organizationMapper.getOrganizationList(param);
    }
    @PostMapping("/ajax/selectUsertList.do")
    public List<User> ajaxSelectUsertList(User user, HttpSession session){
        //System.out.println("selectUsertList : "+user);
        User loginUser = (User)session.getAttribute("loginUser");
        user.setAuth(loginUser.getAuth());
        if(user.getOrganizationSeq()==0){
            user.setOrganizationSeq(null);
        }
        if(user.getUseYN().equals("all")){
            user.setUseYN(null);
        }
        //System.out.println("검색체크 : "+user);
        return userMapper.getCompanyAllUserList(user);
    }
    @GetMapping("/ajax/selectUserInfo.do")
    public Map<String,Object> ajaxSelectUserInfo(User user, @RequestParam Map<String, Object> param){
        Map<String, Object> responseMap = new HashMap<>();
        Map<String, Object> map = new HashMap<>();
        //System.out.println("수정할 vm "+vendingMachineMapper.getUserVM(map));
        responseMap.put("comList",companyMapper.getAllCompanyList());
        responseMap.put("orgList",organizationMapper.getOrgOfComList(param));
        responseMap.put("userInfo",userMapper.getUserInfoDetail(user));
        return responseMap;
    }
    @PostMapping("/ajax/insModUser.do")
    public String ajaxInsModUser(User user
            , HttpServletRequest request){
        //System.out.println("수정할 유저정보 : "+user);
        return companyService.insertAndModifyUser(user,request);
    }
    @GetMapping("/ajax/deleteSelectedUser.do")
    public String ajaxDeleteSelectedUser(@RequestParam(value="deleteList[]") List<Integer> deleteList){
        return companyService.deleteUserList(deleteList);
    }

    @GetMapping("/ajax/idCheck.do")
    public String ajaxIdCheck(User user){
        //System.out.println(" seq만 확인(아이디 중복체크) :"+user);
        if(userMapper.idCheckDup(user)!=null){
            return "이미 사용중인 아이디 입니다.";
        }
        return "등록 가능한 아이디 입니다.";
    }
    //이벤트관련
    @PostMapping("/ajax/searchEventList.do")
    public Map<String,Object> ajaxSearchEventList(@RequestParam Map<String, Object> param){
        Map<String, Object> responseMap = new HashMap<>();
        Map<String, Object> tempMap = new HashMap<>();
        tempMap.putAll(param);
        tempMap.put("event2",1);

        responseMap.put("eventList",eventMapper.searchEventList(param));

        if(param.get("eDate")!=null){
            if(!param.get("eDate").equals(""))
            param.put("eDate", Integer.toString(Integer.parseInt(param.get("eDate").toString())+1));
        }
        /*if(Integer.parseInt(param.get("organizationSeq").toString())==0){ //조직 전체일때
            List<Organization> org = organizationMapper.getOrgOfComList(param);
            param.put("organizationSeq",org.get(0).getOrganizationSeq());
        }*/
        responseMap.put("vmInfo", vendingMachineMapper.getVMOfOrgList(param));
        responseMap.put("productInfo",vendingMachineProductMapper.getEventVMProductList(tempMap));//select
        responseMap.put("productList",vendingMachineProductMapper.getEventVMProductList(param));//table
        //System.out.println("selectOrig 컨트롤러 : "+param+"/tempMap: "+tempMap);

        //System.out.println("==> "+responseMap);
        //System.out.println(vendingMachineProductMapper.getEventVMProductList(tempMap));
        return responseMap;
    }

    @PostMapping("/ajax/selectVMList2.do")
    public Map<String,Object> ajaxSelectVMList(@RequestParam Map<String, Object> param){
        Map<String, Object> responseMap = new HashMap<>();
        //logger.info("/company/ajax/selectVMList.do >> map:{}",param );
        if(param.get("page")==null){}
        else if(param.get("page").equals("adv")){
            List<Adv> advList = advMapper.getSearchAdvList(param);
            responseMap.put("advList",advList);
            if(param.get("advSeq")!=null){
                //System.out.println(advList.size()+" map확인1:"+param);
                if(Integer.parseInt(param.get("advSeq").toString())!=0){
                    param.put("advSeq",0);
                    param.put("organizationSeq",advList.get(0).organizationSeq);
                    responseMap.put("advInfo",advMapper.getSearchAdvList(param));
                    //System.out.println(advMapper.getSearchAdvList(param).size()+" map확인2:"+param);
                }else responseMap.put("advInfo",advList);
            }else responseMap.put("advInfo",advList);
        }

        else if(param.get("page").equals("event")) {
            List<Event> eventList = eventMapper.searchEventList(param);
            responseMap.put("eventList",eventList);//선택한 이벤트(소속별/조직별/이벤트별) 리스트
            if(param.get("eventSeq")!=null){
                //System.out.println(eventList.size()+" map확인1:"+param);
                if(Integer.parseInt(param.get("eventSeq").toString())!=0){
                    param.put("eventSeq",0);
                    param.put("organizationSeq",eventList.get(0).organizationSeq);
                    responseMap.put("eventInfo",eventMapper.searchEventList(param));
                    //System.out.println(eventMapper.searchEventList(param).size()+" map확인2:"+param);
                }else responseMap.put("eventInfo",eventList);
            }else responseMap.put("eventInfo",eventList);//해당 조직의 이벤트 전체
        }

        else if(param.get("page").equals("event2")) {
            //상품리스트 추가
            List<VendingMachineProduct> productList = vendingMachineProductMapper.getEventVMProductList(param);
            responseMap.put("productList",productList);//선택한 상품(조직별/자판기별) 리스트>tr
            //자판기전체일땐 org 0으로 /vmSeq 0아니면 선택돼 있으면
            //System.out.println(productList.size());
            if (!param.get("productCode").toString().equals("all")) {
                //System.out.println(productList.size() + " map확인1:" + param);
                param.put("productCode", "all");
                param.put("event2", 1);
                responseMap.put("ProductInfo", productList);
            /*if(Integer.parseInt(param.get("vmSeq").toString())!=0){
                //param.put("vmSeq",0);
                param.put("event2",1);
                //param.put("organizationSeq",productList.get(0).organizationSeq);
                responseMap.put("ProductInfo",vendingMachineProductMapper.getEventVMProductList(param));
                System.out.println(vendingMachineProductMapper.getEventVMProductList(param).size()+" map확인2:"+param);
            }else param.put("event2",1); responseMap.put("ProductInfo",productList);*/
            } else {
                param.put("event2", 1);
                //System.out.println("even2 " + param);
                responseMap.put("ProductInfo", vendingMachineProductMapper.getEventVMProductList(param));//해당 조직의 상품 전체(distinct) select용
            }

        }

        responseMap.put("orgInfo", organizationMapper.getOrgOfComList(param));//해당 소속의 조직 전체 리스트
        responseMap.put("vmInfo", vendingMachineMapper.getVMOfOrgList(param));//해당 조직의 자판기 전체 리스트
        responseMap.put("vmList",vendingMachineMapper.getSearchVM(param));//선택한 자판기(소속별/조직별/자판기별) 리스트

        //System.out.println("responseMap 확인: "+responseMap);
        return responseMap;
    }
    @PostMapping("/ajax/insertEventToVMProduct.do")
    public String ajaxInsertEventToVMProduct( @RequestParam(value="vmList[]") List<String> vmList,
                                       @RequestParam(value="eventList[]") List<Integer> eventList,
                                       HttpSession session){
        Map<String, Object> map = new HashMap<>();
        boolean result = false;
        map.put("modifyUserSeq", (Integer) session.getAttribute("userSeq"));
        map.put("eventSeq", eventList.get(0));
        for(String list : vmList){
            map.put("productCode",list.split("/")[0]);
            map.put("vmSeq",list.split("/")[1]);
            result = eventMapper.updateVMProductEvent(map);
            if(!result){
                return "에러발생";
            }
        }
        //System.out.println("list: "+ map);
        //result = eventMapper.updateVMProductEvent_v2(map);
        return (result?"추가되었습니다.":"에러발생");
    }
    @PostMapping("/ajax/insertEvent.do")
    public String ajaxInsertEvent(@RequestParam Map<String, Object> param,Event event, HttpSession session) throws NoSuchAlgorithmException, IOException {
        //System.out.println("insertEvent 컨트롤러 : "+event);
        String[] organizationSeq = param.get("array_organizationSeq").toString().split(",");
        event.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
        event.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
        return (companyService.insertEvent(event, organizationSeq)>0?"적용되었습니다.":"에러발생");
    }
    @GetMapping("/ajax/deleteEvent.do")
    public String ajaxDeleteEvent(@RequestParam(value="deleteList[]") List<Integer> deleteList
            , HttpSession session){
        //광고 삭제
        //logger.info("deleteEvent  : {}", deleteList);
        return companyService.deleteEvent(deleteList, session);
    }
    @PostMapping("/ajax/getEventDetail.do")
    public Map<String,Object> ajaxGetEventDetail(@RequestParam Map<String, Object> param){
        //System.out.println("getEventDetail 컨트롤러 : "+param);
        Map<String, Object> responseMap = new HashMap<>();
        Map<String, Object> map2 = new HashMap<>();
        Map<String, Object> map3 = new HashMap<>();
        map2.putAll(param);
        map3.putAll(param);
        map2.put("event2",1);
        map3.put("event3",1);

        responseMap.put("productList",vendingMachineProductMapper.getEventVMProductList(param));
        responseMap.put("productInfo",vendingMachineProductMapper.getEventVMProductList(map2));
        responseMap.put("productInfo2",vendingMachineProductMapper.getEventVMProductList(map3));
        responseMap.put("eventInfo",eventMapper.getEventInfo(Integer.parseInt(param.get("eSeq").toString())));
        //System.out.println("detail확인; "+responseMap);
        return responseMap;
    }
    @GetMapping("/ajax/deleteSelectedProductFromEvent.do")
    public String ajaxDeleteSelectedProductFromEvent(@RequestParam(value="deleteList[]") List<Integer> deleteList
            ,@RequestParam(value="vmSeq") int vmSeq, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("deleteList",deleteList);
        map.put("vmSeq",vmSeq);
        //logger.info("deleteSelectedAdvFromVM  : {}", deleteList);
        boolean result = advMapper.deleteAdvFromVM(map);
        return (result?"삭제되었습니다.":"에러발생");
    }
    @PostMapping("/ajax/getEventInfo.do")
    public Map<String,Object> ajaxGetEventInfo( @RequestParam(value="eventList[]") List<Integer> eventList){
        //System.out.println("getEventInfo 컨트롤러(추가/수정용) : "+eventList);
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> responseMap = new HashMap<>();
        Event event = eventMapper.getEventInfo2(eventList.get(0));
        map.put("organizationSeq",event.getOrganizationSeq());
        //map.put("eventSeq",advList.get(0));
        //System.out.println("이벵정보확인 "+ event);
        responseMap.put("eventInfo", event);
        responseMap.put("orgInfo",organizationMapper.getOrgOfComList(map)); //조직리스트
        //responseMap.put("orgList",advMapper.getSearchAdvList(map)); //광고등록된 조직리스트뽑을려고
        return responseMap;
    }
    @GetMapping("/ajax/deleteSelectedVMProductFromEvent.do")
    public String ajaxDeleteSelectedVMProductFromEvent(@RequestParam(value="deleteList[]") List<String> deleteList
            ,@RequestParam(value="eventSeq") int eventSeq, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        boolean result = false;
        //map.put("deleteList",deleteList);
        map.put("modifyUserSeq", (Integer) session.getAttribute("userSeq"));
        map.put("eventSeq",null);
        List<VendingMachineProduct> alist = new ArrayList<>();
        for(String list : deleteList){
            map.put("productCode",list.split("/")[1]);
            map.put("vmSeq",Integer.parseInt(list.split("/")[0]));
            //System.out.println("map "+map);
            result = eventMapper.updateVMProductEvent(map);
            if(!result){
                return "에러발생";
            }
        }
        return (result?"삭제되었습니다.":"에러발생");
    }







    //광고시작
    @PostMapping("/ajax/getAdvInfo.do")
    public Map<String,Object> ajaxGetAdvInfo( @RequestParam(value="advList[]") List<Integer> advList){
        //System.out.println("ajaxGetAdvInfo 컨트롤러(추가/수정용) : "+advList);
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> responseMap = new HashMap<>();
        Adv adv = advMapper.getAdvInfo(advList.get(0));
        map.put("companySeq",adv.getCompanySeq());
        map.put("advSeq",advList.get(0));
        //System.out.println("광고정보확인 "+ adv);
        responseMap.put("advInfo", adv);
        responseMap.put("orgInfo",organizationMapper.getOrgOfComList(map)); //조직리스트
        responseMap.put("orgList",advMapper.getSearchAdvList(map)); //광고등록된 조직리스트뽑을려고
        return responseMap;
    }
    @PostMapping("/ajax/getAdvDetailAdv.do")
    public Map<String,Object> ajaxGetAdvDetailAdv( @RequestParam(value="advList[]") List<Integer> advList,
                                                     HttpServletRequest request, HttpSession session){
        //System.out.println("ajaxInsertProgramtoVM 컨트롤러 : "+advList);
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> responseMap = new HashMap<>();
        map.put("advSeq",advList.get(0));
        //map.put("modifyUserSeq", (Integer) session.getAttribute("userSeq"));
        //System.out.println("추가전 확인 "+ map);
        responseMap.put("advInfo",advMapper.getAdvInfo(advList.get(0)));
        return responseMap;
    }
    @GetMapping("/ajax/getDetailAdvInfo.do")
    public Map<String,Object> ajaxGetDetailAdvInfo(@RequestParam Map<String, Object> param){
        //logger.info("ajaxGetDetailAdvInfo  : {}", param);
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("advVMList",vendingMachineMapper.getAdvSearchVMList(param));
        responseMap.put("advInfo",advMapper.getAdvInfo(Integer.parseInt(param.get("advSeq").toString())));
        return  responseMap;
    }

    @PostMapping("/ajax/getAdvDetailVM.do")
    public Map<String,Object> ajaxGetAdvDetailVM(@RequestParam Map<String, Object> param){
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("advList",advMapper.getVMAdvList2(param));
        responseMap.put("vmInfo",vendingMachineMapper.getUserVM(param));
        //System.out.println("ajaxGetAdvDetailVM 컨트롤러 : "+param);
        return responseMap;
    }

    @PostMapping("/ajax/insertAdvToVM.do")
    public String ajaxInsertAdvToVM( @RequestParam(value="vmList[]") List<Integer> vmList,
                                         @RequestParam(value="advList[]") List<Integer> advList,
                                         HttpSession session){
        //System.out.println("ajaxInsertAdvToVM 컨트롤러 : "+advList);
        Map<String, Object> map = new HashMap<>();
        //int advSeq = advList.get(0);
        int createUserSeq = (Integer) session.getAttribute("userSeq");
        int count=0;
        List<VendingMachineAdv> alist = new ArrayList<>();

        //중복체크 해야하나?
        for (int advSeq : advList) {
            for (int vmSeq : vmList) {
                VendingMachineAdv insVmAdv = new VendingMachineAdv();
                insVmAdv.setVmSeq(vmSeq);
                insVmAdv.setAdvSeq(advSeq);
                insVmAdv.setCreateUserSeq(createUserSeq);

                if(advMapper.checkDupAdv(insVmAdv).isEmpty()) {
                    //중복체크해서 제외시키기(알림없음)
                    alist.add(insVmAdv);
                }
            }
        }
        //System.out.println(alist.size()+"/insVmAdv리스트: "+ alist);
        //System.out.println();
        if(alist.isEmpty()){
            return "이미 추가된 광고입니다.";
        }
        count += advMapper.insertVMAdv_v2(alist);
        logger.info("광고 추가한 자판기 개수 : {}",count);
        return (count>0?"추가되었습니다.":"에러발생");
    }
    @PostMapping("/ajax/insertAdv.do")
    public String ajaxInsertAdv(@RequestParam Map<String, Object> param, @RequestPart(value = "upload_advfile", required = false) MultipartFile file, Adv adv, HttpSession session) throws NoSuchAlgorithmException, IOException {

        //System.out.println("ajaxInsertAdv 컨트롤러 : "+adv);
        String[] organizationSeq = param.get("array_organizationSeq").toString().split(",");
        adv.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
        adv.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
        //System.out.println(organizationSeq+"dd "+organizationSeq.length);

        int result = companyService.insertAdv(adv, file, organizationSeq);
        if(result == 400){
            return "H.265 (HEVC) 코덱 파일은 지원하지 않습니다.";
        } else if(result < 0){
            return "에러발생";
        }
        return "적용되었습니다.";
    }
    /*@GetMapping("/ajax/deleteSelectedAdvVM.do")
    public String ajaxDeleteSelectedAdvVM(@RequestParam(value="deleteList[]") List<Integer> deleteList, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        //해당 광고 등록한 자판기 삭제
        map.put("insert_vmList",deleteList);
        map.put("firmwareSeq","");
        map.put("modifyUserSeq", (Integer) session.getAttribute("userSeq"));
        logger.info("deleteSelectedProgramVM  : {}", deleteList);
        boolean result = firmwareMapper.insertProgramToVM(map);
        //파일 삭제

        return (result==true?"삭제되었습니다.":"에러발생");
    }*/

    @GetMapping("/ajax/deleteAdv.do")
    public String ajaxDeleteAdv(@RequestParam(value="deleteList[]") List<Integer> deleteList
            , HttpSession session){
        //광고 삭제
        //logger.info("ajaxDeleteAdv  : {}", deleteList);
        return companyService.deleteAdv(deleteList);
    }

    @GetMapping("/ajax/deleteSelectedAdvFromVM.do")
    public String ajaxDeleteSelectedAdvFromVM(@RequestParam(value="deleteList[]") List<Integer> deleteList
            ,@RequestParam(value="vmSeq") int vmSeq, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("deleteList",deleteList);
        map.put("vmSeq",vmSeq);
        //logger.info("deleteSelectedAdvFromVM  : {}", deleteList);
        boolean result = advMapper.deleteAdvFromVM(map);
        return (result?"삭제되었습니다.":"에러발생");
    }
    @GetMapping("/ajax/deleteSelectedVMFromAdv.do")
    public String ajaxDeleteSelectedVMFromAdv(@RequestParam(value="deleteList[]") List<Integer> deleteList
            ,@RequestParam(value="advSeq") int advSeq, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("deleteList",deleteList);
        map.put("advSeq",advSeq);
        //logger.info("deleteSelectedVMFromAdv  : {}", deleteList);
        boolean result = advMapper.deleteVMFromAdv(map);
        return (result?"삭제되었습니다.":"에러발생");
    }
    @GetMapping("/ajax/getCompanyList.do")
    public List<Company> ajaxGetCompanyList(){
        return companyMapper.getAllCompanyList();
    }
    @GetMapping("/ajax/getOrgList.do")
    public List<Organization> ajaxGetOrgList(HttpSession session){
        User user = (User)session.getAttribute("loginUser");
        Map<String, Object> map = new HashMap<>();
        map.put("companySeq", user.getCompanySeq());
        if(user.getAuth()>2){
            map.put("organizationSeq2",user.getOrganizationSeq());
        }
        return organizationMapper.getOrgOfComList(map);
    }





}
