package kr.co.ubcn.multivm.controller;

import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import kr.co.ubcn.multivm.service.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    OrganizationMapper organizationMapper;
    @Autowired
    AdminService adminService;
    @Autowired
    FirmwareMapper firmwareMapper;
    @Autowired
    VendingMachineMapper vendingMachineMapper;
    @Autowired
    MultivmLogMapper multivmLogMapper;
    @Autowired
    VendingMachineStatusMapper vendingMachineStatusMapper;
    @Autowired
    VendingMachineInfoMapper vendingMachineInfoMapper;
    @Autowired
    VendingMachineIssueMapper vendingMachineIssueMapper;

    @Autowired
    CodeMapper codeMapper;



    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @GetMapping("/firmware")
    public ModelAndView adminAdvertise(ModelAndView mav, HttpServletRequest request){
        return adminService.setAdminPage(mav, request,"firmware");
    }
    @GetMapping("/vm-status")
    public ModelAndView adminVMStatus(ModelAndView mav, HttpServletRequest request){
        return adminService.setAdminPage(mav, request,"vm-status");
    }
    @GetMapping("/log")
    public ModelAndView adminLog(ModelAndView mav, HttpServletRequest request){
        return adminService.setAdminPage(mav, request,"log");
    }
    @GetMapping("/vm-issue")
    public ModelAndView adminVMIssue(ModelAndView mav, HttpServletRequest request){
        return adminService.setAdminPage(mav, request,"vm-issue");
    }
    @GetMapping("/code")
    public ModelAndView adminCode(ModelAndView mav, HttpServletRequest request){
        return adminService.setAdminPage(mav, request,"code");
    }

    @PostMapping("/ajax/selectProgram.do")
    public List<Firmware> ajaxSelectProgram(HttpServletRequest request, @RequestParam Map<String, Object> param){
        return firmwareMapper.getSearchFirmwareList(param);
    }
    @PostMapping("/ajax/getProgramInfo.do")
    public Firmware ajaxGetProgramInfo(HttpServletRequest request){
        return firmwareMapper.getFirmwareInfo(Integer.parseInt(request.getParameter("seq")));
    }

    @GetMapping("/ajax/deleteSelectedProgram.do")
    public String ajaxDeleteSelectedProgram(@RequestParam(value="deleteList[]") List<Integer> deleteList, HttpSession session){
        return (adminService.deleteProgram(deleteList, session)?"삭제되었습니다.":"에러발생");
    }

    @PostMapping("/ajax/insertProgramToVM.do")
    public String ajaxInsertProgramToVM( @RequestParam(value="vmList[]") List<Integer> vmList,
                                         @RequestParam(value="programList[]") List<Integer> programList,
                                         HttpServletRequest request, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("firmwareSeq",programList.get(0));
        map.put("insert_vmList",vmList);
        map.put("modifyUserSeq", (Integer) session.getAttribute("userSeq"));
        boolean result = firmwareMapper.insertProgramToVM(map);
        return (result==true?"추가되었습니다.":"에러발생");
    }

    @PostMapping("/ajax/insertProgram.do")
    public String ajaxInsertProgram(@RequestParam("upload_firmwarefile") MultipartFile file, Firmware firmware, HttpSession session) throws NoSuchAlgorithmException, IOException {
        firmware.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
        int result = adminService.insertFirmware(firmware, file);
        return (result==1?"추가되었습니다.":"에러발생");
    }

    @GetMapping("/ajax/getDetailProgramInfo.do")
    public Map<String,Object> ajaxGetDetailProgramInfo(@RequestParam(value="seq") int seq){
        return adminService.getProgramDetail(seq);
    }


    @GetMapping("/ajax/selectVMList.do")
    public Map<String,Object> ajaxSelectVMList(@RequestParam Map<String, Object> param){
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("orgInfo", organizationMapper.getOrgOfComList(param));
        responseMap.put("vmInfo", vendingMachineMapper.getVMOfOrgList(param));
        responseMap.put("vmList",vendingMachineMapper.getSearchVM(param));
        return responseMap;
    }

    @GetMapping("/ajax/deleteSelectedProgramVM.do")
    public String ajaxDeleteSelectedProgramVM(@RequestParam(value="deleteList[]") List<Integer> deleteList, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("insert_vmList",deleteList);
        map.put("firmwareSeq",null);
        map.put("modifyUserSeq", (Integer) session.getAttribute("userSeq"));
        //logger.info("deleteSelectedProgramVM  : {}", deleteList);
        boolean result = firmwareMapper.insertProgramToVM(map);
        //파일 삭제

        return (result==true?"삭제되었습니다.":"에러발생");
    }

    @PostMapping("/ajax/getSearchLogList.do")
    public List<MultivmLog> ajaxGetSearchLogList(@RequestParam Map<String, Object> param){

        if(param.get("eDate")!=null){
            param.put("eDate", Integer.toString(Integer.parseInt(param.get("eDate").toString())+1));
        }
        return multivmLogMapper.getSearchLogList(param);
    }

    @PostMapping("/ajax/getSearchVMStatusList.do")
    public List<VendingMachineStatus> ajaxGetSearchVMStatusList(@RequestParam Map<String, Object> param, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        if(loginUser.getAuth()==3){
            param.put("organizationSeq",loginUser.getOrganizationSeq());
        }else if(loginUser.getAuth()==4){
            param.put("userSeq",loginUser.getSeq());
        }
        return vendingMachineStatusMapper.getVMStatusList(param);
    }
    @GetMapping("/ajax/getDetailVMStatusInfo.do")
    public Map<String,Object> ajaxGetDetailVMStatusInfo(@RequestParam int vmSeq){
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("vmStatus",vendingMachineStatusMapper.getVMStatus(vmSeq));
        responseMap.put("vmInfo",vendingMachineInfoMapper.getVMInfo(vmSeq));
        //System.out.println(responseMap);
        return responseMap;
    }
    @PostMapping("/ajax/updateVMActionData.do")
    public String ajaxUpdateVMActionData(VendingMachineInfo vendingMachineInfo){
        boolean result = vendingMachineInfoMapper.updateVMActionData(vendingMachineInfo);
        return (result?"수정되었습니다":"에러발생");
    }

    @PostMapping("/ajax/getSearchVMIssueList.do")
    public List<VendingMachineIssue> ajaxGetSearchVMIssueList(@RequestParam Map<String, Object> param, HttpSession session){
        User loginUser = (User)session.getAttribute("loginUser");
        if(loginUser.getAuth()==3){
            param.put("organizationSeq",loginUser.getOrganizationSeq());
        }else if(loginUser.getAuth()==4){
            param.put("userSeq",loginUser.getSeq());
        }
        return vendingMachineIssueMapper.getVMIssueList(param);
    }
    @GetMapping("/ajax/getDetailVMIssueInfo.do")
    public Map<String,Object> ajaxGetDetailVMIssueInfo(@RequestParam int seq){
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("vmIssue",vendingMachineIssueMapper.getVMIssue(seq));
        return responseMap;
    }

    @GetMapping("/ajax/getSearchCodeList.do")
    public List<Code> getSearchCodeList(@RequestParam Map<String, Object> param){
        return codeMapper.getCodeList(param);
    }

    @GetMapping("/ajax/chkDupCode.do")
    public String chkDupCode(Code code){
        return Integer.toString(codeMapper.checkDupCode(code));
    }

    @PostMapping("/ajax/insertCode.do")
    public String insertCode(Code code){
        return Integer.toString(codeMapper.insertCode(code));
    }

    @PostMapping("/ajax/modifyCode.do")
    public String modifyCode(Code code){
        int result = codeMapper.modifyCode(code);
        return Integer.toString(result);
    }


}
