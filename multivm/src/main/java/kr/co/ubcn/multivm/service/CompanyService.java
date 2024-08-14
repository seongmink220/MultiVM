package kr.co.ubcn.multivm.service;

import com.vdurmont.emoji.EmojiParser;
import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import kr.co.ubcn.multivm.util.SFTPUtil;
import kr.co.ubcn.multivm.util.SHA256;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.jdbc.Null;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class CompanyService {

    Logger logger = LoggerFactory.getLogger(ProductService.class);

    @Autowired
    UserMapper userMapper;
    @Autowired
    CompanyMapper companyMapper;
    @Autowired
    OrganizationMapper organizationMapper;
    @Autowired
    VendingMachineMapper vendingMachineMapper;
    @Autowired
    ProductMapper productMapper;
    @Autowired
    AdvMapper advMapper;
    @Autowired
    EventMapper eventMapper;
    @Autowired
    FirmwareMapper firmwareMapper;
    @Autowired
    VendingMachineProductMapper vendingMachineProductMapper;
    @Autowired
    VendingMachineInfoMapper vendingMachineInfoMapper;
    @Autowired
    StockMapper stockMapper;
    @Autowired
    VendingMachineCurrProductMapper vendingMachineCurrProductMapper;
    @Autowired
    StoreMapper storeMapper;
    @Autowired
    ReleaseMapper releaseMapper;
    @Autowired
    VendingMachineStatusMapper vendingMachineStatusMapper;
    @Autowired
    SFTPUtil sftpUtil;

    @Value("${server.img.default.path}")
    private String imgPath;

    @Value("${server.img.default.url}")
    private String imgUrl;

    private String adv_path = "adv/";


    public ModelAndView setCompanyPage(ModelAndView mav, HttpServletRequest request, String page){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");
        if(user==null) return new ModelAndView("redirect:login");
        Map<String, Object> map = new HashMap<>();
        if(user.getAuth()!=0) {
            map.put("companySeq", user.getCompanySeq());
        }
        if(user.getAuth()==3){
            map.put("organizationSeq",user.getOrganizationSeq());
        }
        if(user.getAuth()==4){
            map.put("auth",4);
            map.put("userSeq",user.getSeq());
        }
        List<Organization> orgList = organizationMapper.getOrganizationList(map);
        mav.addObject("companyList",companyMapper.getAllCompanyList())
                .addObject("orgList",orgList)
                .addObject("defaultOrg", organizationMapper.getDefaultOrig(user));

    switch (page) {
            case "vm":
                List<VendingMachine> vmList = vendingMachineMapper.getSearchVM2(map);
                mav.addObject("vmList",vmList)
                        .addObject("totCnt",vmList.size())
                        .setViewName("company/vending-machine");
                break;
            case "user":
                User empty = new User();
                if(user.getAuth()!=0) {
                    empty.setCompanySeq(user.getCompanySeq());
                }
                empty.setAuth(user.getAuth());
                if(user.getAuth()!=0&&user.getAuth()!=1){
                    empty.setOrganizationSeq(user.getOrganizationSeq());
                }
                //System.out.println("empty확인 : "+organizationMapper.getOrganizationList(map));
                List<User> userList = userMapper.getCompanyAllUserList(empty);
                mav.addObject("userList",userList)
                        .addObject("totCnt",userList.size())
                        .addObject("selectOrgSeq", user.getAuth()==3? user.getOrganizationSeq():0) //0으로 해서 전체?(O) 첫번째?
                        .setViewName("company/user");
                break;
            case "orig":
                mav.addObject("totCnt",orgList.size())
                        .setViewName("company/orig");
                break;
            case "register":
                List<Company> companyPageList = companyMapper.getAllCompanyList_admin();
                mav.addObject("companyPageList",companyPageList)
                        .addObject("totCnt",companyPageList.size())
                        .setViewName("company/register");
                break;
            case "adv":
                if(user.getAuth()>2){
                    map.put("organizationSeq",user.getOrganizationSeq());
                }
                mav.addObject("vmList",vendingMachineMapper.getSearchVM2(map))
                        .addObject("advList",advMapper.getSearchAdvList(map))
                        .setViewName("company/adv");
                break;
            case "event":
                if(user.getAuth()!=0) {
                    map.put("organizationSeq",user.getOrganizationSeq());
                }
                map.put("index",1);
                //System.out.println("맵검사: "+map);
                mav.addObject("vmList",vendingMachineMapper.getSearchVM2(map))
                        .addObject("eventList",eventMapper.searchEventList(map))
                        .addObject("vmProductList",vendingMachineProductMapper.getEventVMProductList(map))
                        .setViewName("company/event");
                break;
            default:
        }

        return mav;
    }

    @Transactional
    public Map<String,Object> getOrigAndVMList(HttpServletRequest request, User user){
        Map<String, Object> paramMap = new HashMap<>();
        Map<String, Object> map = new HashMap<>();

        int companySeq = Integer.parseInt(request.getParameter("companySeq"));
        map.put("companySeq",companySeq);

        if(request.getParameter("firmwareSeq")!=null){
            int firmwareSeq = Integer.parseInt(request.getParameter("firmwareSeq"));
            map.put("firmwareSeq",firmwareSeq);
        }
        if(request.getParameter("advSeq")!=null){
            //System.out.println("======> 소속검색시 advSeq 추가");
            int advSeq = Integer.parseInt(request.getParameter("advSeq"));
            map.put("advSeq",advSeq);
            paramMap.put("advList",advMapper.getVMAdvList(map));
        }
        //if(request.getParameter("page")!=null||request.getParameter("page").equals("firmware")){
           //paramMap.put("programList",firmwareMapper.getSearchFirmwareList())
        //}
        //System.out.println("getOrigAndVMList map확인: "+map);
        paramMap.put("origList",organizationMapper.getOrganizationList(map));
        paramMap.put("vmList",vendingMachineMapper.getSearchVM(map));
        paramMap.put("userList",userMapper.getCompanyAllUserList(user));
        return paramMap;
    }

    public String deleteVMList(List<Integer> deleteList){
        Map<String, Object> map = new HashMap<>();
        map.put("deleteList",deleteList);
        map.put("target","vm");
        try {
            //입고,출고,재고, 슬롯정보, 자판기상품, 상태, 정보, 광고 삭제
            stockMapper.deleteStockList_v2(map);
            storeMapper.deleteStoreList_v2(map);
            releaseMapper.deleteReleaseList_v2(map);
            vendingMachineProductMapper.deleteVmProduct_v2(map);
            vendingMachineCurrProductMapper.deleteSlotInfo_v2(map);
            vendingMachineStatusMapper.deleteVMStatusList_v2(map);
            vendingMachineInfoMapper.deleteVMInfoList_v2(map);
            advMapper.deleteVMFromAdv(map);
            //자판기 VISIBLE N 으로 업데이트
            vendingMachineMapper.deleteVM_v3(map);

           /* for(int list : deleteList) {
                vendingMachineMapper.deleteVM(list);
            }*/
        }
        catch (Exception e){
            //System.out.println("error : "+e);
            return "에러 발생";
        }

        return "삭제되었습니다.";
    }

    public String insertAndModifyVM(VendingMachine vendingMachine, HttpServletRequest request){
        HttpSession session = request.getSession();
        Map<String, Object> map = new HashMap<>();
        //System.out.println("vendingMachine체크 : "+vendingMachine);
        try {
             // 추가와 수정일 때, 중복된 단말기 검사
                map.put("vmId", vendingMachine.getVmId());
                map.put("vmSeq",vendingMachine.getSeq());
                map.put("terminalId",vendingMachine.getTerminalId());
                if (vendingMachineMapper.isHasVMId(map) > 0) {
                    return "중복된 자판기ID가 존재합니다.";
                }

                if(vendingMachineMapper.isHasTerminalId(map) > 0){
                    return "사용중인 단말기ID 입니다.";
                }
                /*//관리자 아이디 검사
                map.put("userId", vendingMachine.getUserId());
                if(!vendingMachine.getUserId().equals("")){
                    User empty =userMapper.getUserinfo(map);
                    if(empty==null){
                        System.out.println("존재하지 않는 계정");
                        return "해당 관리자가 존재하지 않습니다.";
                    }
                    else vendingMachine.setUserSeq(empty.getSeq());
                }*/

                if (vendingMachine.getSeq() == 0) {
                    //신규 추가


                    vendingMachine.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
                    //System.out.println("추가추가추가"+vendingMachine);
                    vendingMachineMapper.insertVM(vendingMachine);
                    //vmInfo추가
                    vendingMachineInfoMapper.insertVMInfo_v2(vendingMachine.getVmId());



                }
                else{
                    vendingMachine.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
                    //System.out.println("수정수정수정"+vendingMachine);
                    vendingMachineMapper.modifyVM(vendingMachine);
                }


        }
        catch (Exception e){
            System.out.println("error : "+e);
            return "에러발생";
        }
        return "성공적으로 완료되었습니다.";
    }

    public String deleteOrgList(List<Integer> deleteList, HttpServletRequest request){
        HttpSession session = request.getSession();
        Map<String, Object> map = new HashMap<>();
        map.put("target","organization");
        map.put("selectList","deleteList");
        map.put("modifyUserSeq",(Integer) session.getAttribute("userSeq"));
        List<VendingMachine> checkVM = vendingMachineMapper.isCheckUseVM(map);
        if(!checkVM.isEmpty()){
            return "자판기 등록이력이 있어 삭제가 불가합니다.\n시스템관리자에게 문의하여 주시기 바랍니다.(자판기이동 및 거래이동 필요)";
        }
        //자판기
        try {
            for(int list : deleteList) {
                map.put("organizationSeq",list);
                //자판기 VISIBLE 'N' UPDATE, 조직관리자, 상품 삭제
                vendingMachineMapper.deleteVM_v3(map); //UPDATE
                productMapper.deleteProduct(map); //DELETE
                userMapper.deleteUser_v3(map); //조직관리자는 삭제(VISIBLE N으로 update)
                userMapper.updateOrgUser(map); //모든 사용자 조직 NULL로 update
                organizationMapper.deleteOrg_v2(map); //UPDATE
            }
        }
        catch (Exception e){
            System.out.println("error : "+e);
            return "[에러 발생] 관리자에게 문의하여 주시기 바랍니다.\n※조직에 등록된 사용자 및 자판기 삭제 혹은 이동 필요";
        }

        return "삭제되었습니다.";
    }
    public String deleteCompanyList(List<Integer> deleteList){
        Map<String, Object> map = new HashMap<>();
        // 등록된 자판기가 있는경우엔 삭제 불가
        map.put("target","company");
        map.put("deleteList",deleteList);
        List<VendingMachine> checkVM = vendingMachineMapper.isCheckUseVM(map);
        if(!checkVM.isEmpty()){
            return "자판기 등록이력이 있어 삭제가 불가합니다.";
        }
        try {
             for (int list : deleteList) {
                 // 조직, 사용자, 상품 삭제 (이벤트는 서비스X). !ALL DELETE!
                 map.put("companySeq",list);
                 productMapper.deleteProduct(map);
                 userMapper.deleteUser_v2(map);
                 organizationMapper.deleteOrg(map);
                 companyMapper.deleteCompany(list);
             }

        }
        catch (Exception e){
            System.out.println("error : "+e);
            return "[에러 발생] 관리자에게 문의하여 주시기 바랍니다.";
        }

        return "삭제되었습니다.";
    }

    public String insertAndModifyOrg(Organization organization, HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");
        Map<String, Object> map = new HashMap<>();
        try {
            if (organization.getSeq() == 0) {
                //신규 추가
                if(!organizationMapper.checkDupOrgName(organization).isEmpty()){
                    return "중복된 조직이름이 존재합니다.";
                }
                organization.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
                //System.out.println("추가추가추가"+organization);
                organizationMapper.insertOrg(organization);
            }
            else{
                User user1 = new User();
                user1.setOrganizationSeq(organization.getSeq());
                Organization orig = organizationMapper.getOrganizationInfo(user1);
                if(!orig.getName().equals(organization.getName())){
                    if(!organizationMapper.checkDupOrgName(organization).isEmpty()){
                        return "중복된 조직이름이 존재합니다.";
                    }
                }
                organization.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
                //System.out.println("수정수정수정"+organization);
                organizationMapper.modifyOrg(organization);
            }
        }
        catch (Exception e){
            System.out.println("error : "+e);
            return "에러발생";
        }
        return "성공적으로 완료되었습니다.";
    }

    public String idCheckDup(User user){

        return "";
    }

    public String insertAndModifyCompany(Company company, HttpServletRequest request){
        HttpSession session = request.getSession();
        Map<String, Object> map = new HashMap<>();
        try {
            if (company.getSeq() == 0) {
                //신규 추가
                if(!companyMapper.checkDupCompanyName(company.getName()).isEmpty()){
                    return "중복된 이름이 소속이 존재합니다.";
                }
                company.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
                //System.out.println("추가추가추가"+company);
                companyMapper.insertCompany(company);
            }
            else{
                Company orig = companyMapper.getCompanyInfo(company.getSeq());
                if(!orig.getName().equals(company.getName())){
                    if(!companyMapper.checkDupCompanyName(company.getName()).isEmpty()){
                        return "중복된 이름이 소속이 존재합니다.";
                    }
                }

                company.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
                //System.out.println("수정수정수정"+company);
                companyMapper.modifyCompany(company);
            }
        }
        catch (Exception e){
            System.out.println("error : "+e);
            return "에러발생";
        }
        return "성공적으로 완료되었습니다.";
    }


    public String insertAndModifyUser(User user, HttpServletRequest request){
        HttpSession session = request.getSession();
        try {
            if(userMapper.idCheckDup(user)!=null){
                System.out.println("아이디 중복있음");
                return "사용할 수 없는 아이디입니다.";
            }
            if (user.getSeq() == 0) {
                //신규 추가
                user.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
                //System.out.println("추가추가추가"+user);
                userMapper.insertUser(user);
            }
            else{
                user.setModifyUserSeq((Integer) session.getAttribute("userSeq"));
                //System.out.println("수정수정수정"+user);
                userMapper.modifyUser(user);
            }
        }
        catch (Exception e){
            System.out.println("error : "+e);
            return "에러발생";
        }
        return "성공적으로 완료되었습니다.";
    }

    public String deleteUserList(List<Integer> deleteList){
        Map<String, Object> map = new HashMap<>();
        map.put("deleteList",deleteList);
        map.put("target","user");
        try {
            // 2023-02-15. 자판기 USER_SEQ NULL로 update
            vendingMachineMapper.deleteVM_v3(map);
            // 사용자 VISIBLE N으로 update
            userMapper.deleteUser_v3(map);

            /*List<String> vmList = userMapper.getUserVMList(map);
            if(!vmList.isEmpty()){
                return "[에러 발생] 자판기에 등록된 관리자ID 있음 (※변경 혹은 삭제 필요)\n자판기ID: "+vmList.toString();
            } else {
                userMapper.deleteUser_v2(map);
            }*/
        }
        catch (Exception e){
            System.out.println("error : "+e);
            return "[에러 발생] 관리자에게 문의하여 주시기 바랍니다.";
        }

        return "삭제되었습니다.";
    }

    @Transactional
    public int insertAdv(Adv adv, MultipartFile file, String[] org) {
        int result = 0;
        String orgFileName = EmojiParser.removeAllEmojis(file.getOriginalFilename());
        //파일저장
        //String localtest ="D:/logs/";
        try {
            if(isHEVCAdvertising(file)){ return 400; }  // 코덱 파일일 유효성 검사

            sftpUtil.init();
            sftpUtil.mkdir(adv_path);

            if (file != null || !file.isEmpty()) {

                SimpleDateFormat format = new SimpleDateFormat("yyMMddHHmmss");
                //String fileName = Integer.toString((int) (Math.random() * 100)) + "_" + StringUtils.cleanPath(file.getOriginalFilename());
                String fileName = format.format(new Date()) + Integer.toString((int)(Math.random() * (9999 - 1000 + 1)) + 1000) +"."+ FilenameUtils.getExtension(orgFileName);//20자

                //20자 이름규칙
                adv.setOriginFile(StringUtils.cleanPath(orgFileName));
                adv.setAdvFile(fileName);

                sftpUtil.upload(adv_path, file, fileName);

                //Files.copy((new File(adv_dn_path + file.getOriginalFilename())).toPath(), Paths.get(adv_dn_path + fileName),StandardCopyOption.REPLACE_EXISTING);

                for(int i=0; i<org.length; i++) {

                    if(adv.getSeq()==0){
                        adv.setOrganizationSeq(Integer.parseInt(org[i]));
                        result += advMapper.insertAdv(adv);
                    }
                    else{ //이전 파일 삭제
                        String bfAdvFile = advMapper.checkUseAdvFile(adv.getSeq());
                        //File bfile = new File(adv_dn_path + bAdv.getAdvFile());bfile.delete();
                        if(bfAdvFile != null) sftpUtil.delete(adv_path, bfAdvFile);
                    }
                }
                /*if (adv.getSeq() != 0) {
                    //기존 파일 삭제
                    Adv bAdv = advMapper.getAdvInfo(adv.getSeq());
                    File bfile = new File(adv_dn_path + bAdv.getAdvFile());
                    bfile.delete();
                }*/
            }
            sftpUtil.disconnection();
        }catch(Exception e){
            e.getStackTrace();
        }
        /*if(adv.getSeq()==0){
            //생성
            for(int i=0; i<org.length; i++){
                adv.setOrganizationSeq(Integer.parseInt(org[i]));
                result += advMapper.insertAdv(adv);
            }
        }*/
        if(adv.getSeq()!=0){
            result +=advMapper.modifyAdv(adv);
        }
        return result;
    }

    @Transactional
    public String deleteAdv(List<Integer> deleteList){
        Map<String, Object> map = new HashMap<>();
        map.put("deleteList",deleteList);
        try {
            //파일삭제 추가예정
            sftpUtil.init();
            for(int list : deleteList){
                String bfAdvFile = advMapper.checkUseAdvFile(list);
                if(bfAdvFile != null) sftpUtil.delete(adv_path, bfAdvFile);
            }
            advMapper.deleteAdvFromVM(map);
            advMapper.deleteAdv(map);
            sftpUtil.disconnection();
        }
        catch (Exception e){
            System.out.println("광고삭제 error : "+e);
        }
        return "삭제되었습니다.";
    }

    public int insertEvent(Event event, String[] org){
        int result = 0;
        if(event.getSeq()==0){
            //생성
            for(int i=0; i<org.length; i++){
                event.setOrganizationSeq(Integer.parseInt(org[i]));
                result += eventMapper.insertEvent(event);
            }
        }else{
            Map<String, Object> map = new HashMap<>();
            map.put("d_eventSeq", event.getSeq());
            eventMapper.updateVMProductEvent(map);
            result +=eventMapper.modifyEvent(event);
        }
        return result;
    }

    public String deleteEvent(List<Integer> deleteList,HttpSession session ){
        Map<String, Object> map = new HashMap<>();
        map.put("deleteList",deleteList);
        map.put("modifyUserSeq",(Integer) session.getAttribute("userSeq"));
        map.put("eventSeq",null);

        try {
            for(int list : deleteList){
                map.put("d_eventSeq", list);
                eventMapper.updateVMProductEvent(map);
            }
            eventMapper.deleteEvent(map);
        }
        catch (Exception e){
            System.out.println("이벤트삭제 error : "+e);
        }
        return "삭제되었습니다.";
    }

    // 20240812 - 김성민 : 광고 등록시 코덱방식 파일 업로드 불가 유효성검사
    public boolean isHEVCAdvertising(MultipartFile multipartFile) throws IOException {

        try (InputStream checkFile = multipartFile.getInputStream()){
            try (FFmpegFrameGrabber grabber = new FFmpegFrameGrabber(checkFile)) {
                grabber.start();
                String codecName = grabber.getVideoCodecName();
                grabber.stop();

                System.err.println("requestFile codecName: " + codecName);
                // H.265 코덱 확인
                if (codecName != null && codecName.contains("hevc")) {
                    System.out.println("H.265(HEVC) 코덱을 사용하는 파일입니다. 업로드 불가능 합니다.");
                    return true;
                } else {
                    System.out.println("파일은 H.265(HEVC) 코덱을 사용하지 않습니다. 업로드 가능 합니다.");
                    return false;
                }
            }
            catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
    }

}
