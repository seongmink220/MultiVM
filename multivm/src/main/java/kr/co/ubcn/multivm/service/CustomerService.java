package kr.co.ubcn.multivm.service;

import kr.co.ubcn.multivm.mapper.NoticeMapper;
import kr.co.ubcn.multivm.model.Notice;
import kr.co.ubcn.multivm.model.NoticeFile;
import kr.co.ubcn.multivm.util.SFTPUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Service
public class CustomerService {
    @Autowired
    NoticeMapper noticeMapper;

    @Autowired
    SFTPUtil sftpUtil;

    @Value("${server.img.default.path}")
    private String imgPath;

    @Value("${server.img.default.url}")
    private String imgUrl;

    private String detail_path = "detail/";
    private String notice_path = "notice/";

    @Transactional
    public String setCustomerNotice(Notice notice, MultipartHttpServletRequest Filedata,HttpServletResponse response) throws IOException {
        HashMap<String, Object> map = new HashMap<>();
        /*if(notice.getType().equals("write")){
            noticeMapper.insertNotice(notice);
            notice.setSeq(noticeMapper.getNewNotice());
        }else noticeMapper.updateNotice(notice);*/

        List<MultipartFile> fileList = Filedata.getFiles("files");
        if(!fileList.isEmpty()){
            sftpUtil.init();
            sftpUtil.mkdir(notice_path);

            if(notice.getType().equals("update")){ //파일 체크 해줘야함(현재는 전체 삭제) >
                //map.put("noticeSeq",notice.getSeq());
                //noticeMapper.deleteNoticeFile(map);
            }else notice.setSeq(noticeMapper.getNewNotice()+1);
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            String uid = df.format(new Date()) + Integer.toString((int) (Math.random() * 4));
            //UUID uid = UUID.randomUUID();
            int i = 1;
            for(MultipartFile mf : fileList) {
                String fileName = uid+"_"+mf.getOriginalFilename();

                NoticeFile noticeFile = new NoticeFile();
                noticeFile.setNoticeSeq(notice.getSeq());
                noticeFile.setFileRealName(imgUrl + notice_path + uid+"_"+mf.getOriginalFilename());
                noticeFile.setFileName(mf.getOriginalFilename());
                noticeFile.setFileSize(sizeCalculation(mf.getSize()));

                //File f = new File(notice_dn_path + fileName);
                //System.out.println("uploadFile 컨트롤러 접근 " + noticeFile);


                try {
                    //mf.transferTo(f);
                    sftpUtil.upload(notice_path, mf, fileName);

                    int result = noticeMapper.insertNoticeFile(noticeFile);
                    if(notice.getType().equals("update")) {
                        i = noticeMapper.getCountNoticeFile(notice.getSeq())-1;
                        //System.out.println("i확인 : "+i);
                    }
                    switch (i) {
                        case (1): notice.setFile1(noticeFile.getSeq());break;
                        case (2): notice.setFile2(noticeFile.getSeq());break;
                        case (3): notice.setFile3(noticeFile.getSeq());break;
                        case (4): notice.setFile4(noticeFile.getSeq());break;
                        default:
                    }

                    //System.out.println("uploadFile 컨트롤러 222" + fileName);
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
                i++;
            }
            sftpUtil.disconnection();
        }

        if(notice.getType().equals("write")){
            //System.out.println("추가될 notice "+notice);
            noticeMapper.insertNotice(notice);
            notice.setSeq(noticeMapper.getNewNotice());
        }else noticeMapper.updateNotice(notice);





        return Integer.toString(notice.getSeq());
    }


    @Transactional
    public void setUploadFile(HttpServletRequest request, HttpServletResponse response
            , MultipartFile upload) throws MalformedURLException {
        UUID uid = UUID.randomUUID();
        OutputStream out = null;
        PrintWriter printWriter = null;

        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        /*URL requestURL = new URL(request.getRequestURL().toString());
        String port = requestURL.getPort() == -1 ? "" : ":" + requestURL.getPort();
        String url = requestURL.getProtocol() + "://" + requestURL.getHost() + port;*/

        try{
            sftpUtil.init();
            sftpUtil.mkdir(detail_path);

            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();

            String ckUploadPath = imgPath + detail_path + uid  + "_" + fileName;
            /*File folder = new File(imgPath + detail_path);
            if(!folder.exists()){
                try{
                    folder.mkdirs();
                }catch(Exception e){
                    e.getStackTrace();
                }
            }*/
            sftpUtil.upload(detail_path, upload, uid  + "_" + fileName);
            /*out = new FileOutputStream(new File(ckUploadPath));
            out.write(bytes);
            out.flush();*/

            String callback = request.getParameter("CKEditorFuncNum");
            printWriter = response.getWriter();
            //이미지 업로드 경로 추가
            //String fileUrl = "/customer/ckeditor/imgSubmit.do?uid=" + uid + "&fileName=" + fileName;
            String fileUrl_s = "http://devmultivm.ubcn.co.kr/detail?uid=" + uid + "&fileName=" + fileName;
            //String fileUrl_s = url+"/detail?uid=" + uid + "&fileName=" + fileName;
            printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl_s+"\"}");
            printWriter.flush();
            sftpUtil.disconnection();

        }catch(IOException e){
            e.printStackTrace();
        }finally{
            try {
                if(out != null) { out.close(); }
                if(printWriter != null) { printWriter.close(); }
            }catch(IOException e) { e.printStackTrace(); }
        }
    }

    // 파일 저장
    public void setSubmitFile(String uid, String fileName, HttpServletResponse response) throws IOException {
        //String sDirPath = imgPath + detail_path + uid + "_" + fileName;
        String sDirPath = imgPath + detail_path + uid + "_" + fileName;
        File imgFile = new File(sDirPath);

        if(imgFile.isFile()){
            byte[] buf = new byte[1024];
            int readByte = 0;
            int length = 0;
            byte[] imgBuf = null;

            FileInputStream fileInputStream = null;
            ByteArrayOutputStream outputStream = null;
            ServletOutputStream out = null;


            fileInputStream = new FileInputStream(imgFile);
            outputStream = new ByteArrayOutputStream();
            out = response.getOutputStream();

            while((readByte = fileInputStream.read(buf)) != -1){
                outputStream.write(buf, 0, readByte);
            }

            imgBuf = outputStream.toByteArray();
            length = imgBuf.length;
            out.write(imgBuf, 0, length);
            out.flush();
        }
    }

    public void downloadFile(String fileName, HttpServletResponse response) throws IOException {
        File file = new File(imgPath + notice_path + fileName);
        response.setHeader("Content-Disposition", "attachment;filename=" + file.getName()); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더

        FileInputStream fileInputStream = new FileInputStream(imgPath + notice_path + fileName); // 파일 읽어오기
        OutputStream out = response.getOutputStream();

        int read = 0;
        byte[] buffer = new byte[1024];
        while ((read = fileInputStream.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
            out.write(buffer, 0, read);

        }
    }

    public String sizeCalculation(long size) {
        String CalcuSize = null;
        int i = 0;

        double calcu = (double) size;
        while (calcu >= 1024 && i < 5) { // 단위 숫자로 나누고 한번 나눌 때마다 i 증가
            calcu = calcu / 1024;
            i++;
        }
        DecimalFormat df = new DecimalFormat("#,###.##");
        switch (i) {
            case 0:
                CalcuSize = df.format(calcu) + "Byte";
                break;
            case 1:
                CalcuSize = df.format(calcu) + "KB";
                break;
            case 2:
                CalcuSize = df.format(calcu) + "MB";
                break;
            case 3:
                CalcuSize = df.format(calcu) + "GB";
                break;
            case 4:
                CalcuSize = df.format(calcu) + "TB";
                break;
            default:
                CalcuSize="ZZ"; //용량표시 불가

        }
        return CalcuSize;
    }




}
