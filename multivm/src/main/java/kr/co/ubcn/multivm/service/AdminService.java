package kr.co.ubcn.multivm.service;

import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.Code;
import kr.co.ubcn.multivm.model.Firmware;
import kr.co.ubcn.multivm.model.User;
import kr.co.ubcn.multivm.util.SHA256;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminService {

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
    FirmwareMapper firmwareMapper;
    @Autowired
    MultivmLogMapper multivmLogMapper;
    @Autowired
    VendingMachineInfoMapper vendingMachineInfoMapper;
    @Autowired
    VendingMachineStatusMapper vendingMachineStatusMapper;
    @Autowired
    VendingMachineIssueMapper vendingMachineIssueMapper;

    @Autowired
    CodeMapper codeMapper;

    private String fileDir= "/app/vmms/uploads/multivm/image/product/";
    private String firmware_dn_path = fileDir + "firmware/";


    public ModelAndView setAdminPage(ModelAndView mav, HttpServletRequest request, String page){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");
        if(user==null) return new ModelAndView("redirect:login");

        SimpleDateFormat format = new SimpleDateFormat ( "yyyyMMdd");
        Calendar time = Calendar.getInstance();
        String today = format.format(time.getTime());

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

        mav.addObject("companyList",companyMapper.getAllCompanyList())
                .addObject("orgList",organizationMapper.getOrganizationList(map))
                .addObject("vmList",vendingMachineMapper.getSearchVM2(map));

        switch (page) {
            case "firmware":
                mav.addObject("programList",firmwareMapper.getSearchFirmwareList(map))
                        .setViewName("admin/firmware");
                break;
            case "vm-status":
                mav.addObject("vmStatusList",vendingMachineStatusMapper.getVMStatusList(map))
                        .setViewName("admin/vm-status");
                break;
            case "log":
                map.put("sDate", today);
                map.put("eDate", today);
                mav.addObject("logList",multivmLogMapper.getSearchLogList(map))
                        .setViewName("admin/log");
                break;
            case "vm-issue":
                map.put("sDate", today);
                map.put("eDate", today);
                mav.addObject("vmIssueList",vendingMachineIssueMapper.getVMIssueList(map))
                        .setViewName("admin/vm-issue");
                break;
            case "code":
                map.put("type", "error");
                mav.setViewName("admin/code");
                break;
            default:
        }

        return mav;
    }


    public int insertFirmware(Firmware firmware, MultipartFile file) throws NoSuchAlgorithmException, IOException {
        SHA256 sha256 = new SHA256();
        //MultipartFile upload = file.getFile("upload_firmwarefile");
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        File toFile = sha256.convertToFile(file);
        String fileNameToSha256 = sha256.getFileChecksum(toFile);
                //String fileNameToSha256 = sha256.encrypt(fileName);
        firmware.setSha256(fileNameToSha256);
        firmware.setFileName(fileName);
        //파일저장
        if(file!=null){
            //fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File folder = new File(firmware_dn_path);
            if(!folder.exists()){
                try{
                    folder.mkdirs();
                }catch(Exception e){
                    e.getStackTrace();
                }
            }
            file.transferTo(new File(firmware_dn_path + fileName));
        }
        //System.out.println("추가전 insertProgram 확인: "+firmware);
        int result = firmwareMapper.insertFirmware(firmware);
        return result;
    }

    public boolean deleteProgram(List<Integer> deleteList, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("delete_programList",deleteList);
        //logger.info("deleteProgramList  : {}", deleteList);
        //vm테이블에서도 firm_seq없애야함

        //map.put("insert_vmList",deleteList);
        map.put("firmwareSeq",null);
        map.put("modifyUserSeq", (Integer) session.getAttribute("userSeq"));
        boolean result = false;
        result = firmwareMapper.deleteProgramToVM(map);

        Firmware firmware = new Firmware();
        for(int list : deleteList) {
            firmware = firmwareMapper.getFirmwareInfo(list);
            try {
                File firmware_file = new File(firmware_dn_path + firmware.getFileName());
                firmware_file.delete();
            }catch (Exception e){
                System.out.println("deleteProgram ERROR ==> "+e);
            }
        }

        result = firmwareMapper.deleteFirmwareList(map);
        //System.out.println("delete_program result결과3: "+result);
        return result;
    }

    public Map<String,Object> getProgramDetail(int seq){
        Map<String, Object> paramMap = new HashMap<>();
        Map<String, Object> map = new HashMap<>();
        map.put("firmwareSeq", seq);
        paramMap.put("programInfo",firmwareMapper.getFirmwareInfo(seq));
        paramMap.put("programVMList",vendingMachineMapper.getSearchVM(map));
        return paramMap;
    }




}
