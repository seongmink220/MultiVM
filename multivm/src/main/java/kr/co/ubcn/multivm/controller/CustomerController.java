package kr.co.ubcn.multivm.controller;

import kr.co.ubcn.multivm.mapper.NoticeMapper;
import kr.co.ubcn.multivm.model.Notice;
import kr.co.ubcn.multivm.model.Product;
import kr.co.ubcn.multivm.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    CustomerService customerService;
    @Autowired
    NoticeMapper noticeMapper;

    Logger logger = LoggerFactory.getLogger(ProductController.class);

    String filePath = "";
    @GetMapping("/notice")
    public ModelAndView serviceNotice(ModelAndView mav,HttpServletRequest request){
        Map<String, Object> map = new HashMap<>();
        mav.addObject("noticeList",noticeMapper.getNoticeList(map))
                .setViewName("customer/notice");
        return mav;
    }
    @GetMapping("/view")
    public ModelAndView serviceView(ModelAndView mav,HttpServletRequest request){
        int seq = Integer.parseInt(request.getParameter("seq"));
        //System.out.println("/// "+noticeMapper.getNoticeInfo(Integer.parseInt(request.getParameter("seq"))));
        List<Notice> prevAndNext = noticeMapper.getNoticePrevAndNext(seq);
        if(!prevAndNext.isEmpty()){
            if(prevAndNext.size()>1){
                mav.addObject("prev",(prevAndNext.get(0)!=null?prevAndNext.get(0):null));
                mav.addObject("next",(prevAndNext.get(1)!=null?prevAndNext.get(1):null));
            }
            else mav.addObject((prevAndNext.get(0).getSeq()>seq?"next":"prev"),prevAndNext.get(0));
        }
        System.out.println("파일리스트 : "+noticeMapper.getNoticeFileList(seq));
        mav.addObject("noticeInfo",noticeMapper.getNoticeInfo(seq))
                .addObject("noticeFile",noticeMapper.getNoticeFileList(seq))
                .setViewName("customer/view");

        return mav;
    }
    @GetMapping("/write")
    public ModelAndView serviceWrite(ModelAndView mav, @RequestParam int seq){
        if(seq!=0)mav.addObject("noticeInfo",noticeMapper.getNoticeInfo(seq)).addObject("noticeFile",noticeMapper.getNoticeFileList(seq)).addObject("type","update");
        else mav.addObject("noticeInfo",null).addObject("noticeFile",null).addObject("type", "write");
        mav.addObject("fileCount",noticeMapper.getCountNoticeFile(seq)).setViewName("customer/write");
        return mav;
    }
    @PostMapping("/write")
    public String serviceWritePost(Notice notice,HttpServletResponse response
            , HttpSession session//, MultipartFile Filedata
                                         , MultipartHttpServletRequest Filedata
    ) throws IOException {
        if(notice.getType().equals("write")){
            notice.setCreateUserSeq((Integer) session.getAttribute("userSeq"));
        }else notice.setModifyUserSeq((Integer) session.getAttribute("userSeq"));

        //return new ModelAndView("redirect:view?seq="+seq);
        return customerService.setCustomerNotice(notice, Filedata, response);
    }

    @PostMapping("/ajax/file-delete.do")
    public String ajaxFileDelete(@RequestParam Map<String, Object> param){
        //HashMap<String, Object> map = new HashMap<>();
        System.out.println(" 삭제할 seq 잘 오는지 확인 "+param.get("seq"));
        noticeMapper.deleteNoticeFile(param);
        //return new ModelAndView("redirect:view?seq="+seq);
        return "파일이 삭제되었습니다.";
    }



    @PostMapping("/ajax/uploadFile.do")
    public String ajaxUploadFile(HttpServletResponse response, HttpServletRequest request
            ,  MultipartFile Filedata
    ) {
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String newfilename = df.format(new Date()) + Integer.toString((int) (Math.random()*10));
        File f = new File("d:\\" + newfilename);
        System.out.println("uploadFile 컨트롤러 접근");
        try {
            Filedata.transferTo(f);
            response.getWriter().write(newfilename);
            System.out.println("uploadFile 컨트롤러 222"+newfilename);
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }
        System.out.println("uploadFile 컨트롤러 333");
        return "gg";

    }
    @PostMapping("/ajax/searchNoticeList.do")
    public List<Notice> ajaxSearchNoticeList(@RequestParam Map<String, Object> param) {
        param.put(param.get("notice_search").toString(),param.get("notice_keyword"));
        System.out.println("searchNoticeList 컨트롤러 222" + param);
        return noticeMapper.getNoticeList(param);

    }
    @GetMapping("/ajax/delete.do")
    public String deleteNotice(ModelAndView mav,@RequestParam int seq){
        HashMap<String, Object> map = new HashMap<>();
        map.put("noticeSeq",seq);
        try {
            noticeMapper.deleteNotice(seq);
            noticeMapper.deleteNoticeFile(map);
        }catch (Exception e){
            return "에러발생";
        }
        return "삭제가 완료되었습니다.";
    }

    @PostMapping("/ckeditor/file-upload.do")
    public void fileUpload(HttpServletRequest request, HttpServletResponse response
            , MultipartFile upload)throws Exception {
        System.out.println(" 접근2");
        System.out.println(" 접근3 : " +  upload.getOriginalFilename());
        customerService.setUploadFile(request, response, upload);

    }
    @GetMapping("/ckeditor/imgSubmit.do")
    public void ckSubmit(@RequestParam(value="uid") String uid
            , @RequestParam(value="fileName") String fileName
            , HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        customerService.setSubmitFile(uid,fileName,response);
    }




}
