package kr.co.ubcn.multivm.controller;

import kr.co.ubcn.multivm.mapper.*;
import kr.co.ubcn.multivm.model.*;
import kr.co.ubcn.multivm.service.AdminService;
import kr.co.ubcn.multivm.util.SFTPUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/popup")
public class PopupController {

    @Autowired
    OrganizationMapper organizationMapper;
    @Autowired
    AdminService adminService;
    @Autowired
    ProductMapper productMapper;
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
    SFTPUtil sftpUtil;

    @Value("${server.img.default.url}")
    private String imgUrl;



    Logger logger = LoggerFactory.getLogger(ProductController.class);

    @GetMapping("/imageAllInsert/{seq}")
    public ModelAndView popupImageAllInsert(HttpServletRequest request, @PathVariable int seq, ModelAndView mav){
        mav.setViewName("imageAllInsert");
        mav.addObject("organizationSeq", seq);
        return mav;
    }

    @Transactional
    @PostMapping("/imageAllInsert/upload")
    public synchronized JSONObject popupImageAllUpload(HttpServletRequest request, Product product
, MultipartHttpServletRequest multipartHttpServletRequest, @RequestParam("fileName") String fileNameStr
    ) throws Exception {

        String[] arr;
        int orderNo = 0;
        String fileName = "";
        Map<String, Object> map = new HashMap();
        MultipartFile file = multipartHttpServletRequest.getFile("file");

        System.out.println("product:"+product);

        // 상품코드 추출
        /*try {
            arr = fileNameStr.split("_", 2);
            System.out.println("base fileName: " + arr[1]);
        }catch (ArrayIndexOutOfBoundsException e){
            logger.info("ArrayIndexOutOfBoundsException error. file all insert fail.");
            map.put("status", "fail");
            map.put("message", "파일명 형식이 잘못되었습니다.");
            JSONObject json = new JSONObject(map);
            return json;
        }*/
        //2023-02-16. 파일명으로 로직변경(확장자 자름)

        product.setImgCode(fileNameStr.substring(0,fileNameStr.lastIndexOf('.')));
        List<Product> isHasCode = productMapper.isHasCodeProductImg(product);
        if(isHasCode.isEmpty()){
            map.put("status", "fail");
            map.put("message", "매칭되는 상품이 없습니다.");
        }
        for(Product i : isHasCode){
            if(i.getProductSeq()==0){
                map.put("status", "fail");
                map.put("message", "매칭되는 상품이 없습니다.");
                /*throw new ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "존재하는 상품코드가 없습니다!"
                );*/
            }else {
                orderNo ++;
                sftpUtil.init();
                /*if(arr[1].length()>16){
                    arr[1].substring(arr[1].length()-16, arr[1].length());
                }*/

                fileName = System.currentTimeMillis() + String.format("%02d", orderNo) + "_" + fileNameStr;
                product.setProductSeq(i.getProductSeq());
                product.setProductImage(imgUrl + fileName);
                // sftp
                if (sftpUtil.upload("", file, fileName)) {
                    productMapper.modifyProduct(product);
                    // 기존 이미지 삭제
                    sftpUtil.delete("", i.getProductImage());
                    map.put("status", "ok");
                } else {
                    map.put("status", "fail");
                    map.put("message", "파일저장 실패. 파일서버 오류");
                }
                sftpUtil.disconnection();
            }
        }
        JSONObject json = new JSONObject(map);
        return json;
    }

}
