package kr.co.ubcn.multivm.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.UUID;

public class CommonUtil {

    public void saveCookie(HttpServletRequest request, HttpServletResponse response){
        try {
            String str1 = URLEncoder.encode("ubcn-multiVM", "UTF-8");
            Cookie cookie = new Cookie("cookie1",str1);
            cookie.setMaxAge(365*24*60*60);
            response.addCookie(cookie);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public void loadCookie(HttpServletRequest request){
        try {

            Cookie[] cookies = request.getCookies();

            for (Cookie cookie : cookies ) {
                String str2 = URLDecoder.decode(cookie.getValue(),"UTF-8");
                //cookie.setMaxAge(0);
                if(cookie.getName().equals("cookie1")){
                    System.out.println("eeee "+str2);
                }

            }

        }catch (Exception e){
            e.printStackTrace();
        }

    }

    public void setUploadFile(HttpServletRequest request, HttpServletResponse response
            , MultipartFile upload, String path) {
        UUID uid = UUID.randomUUID();
        OutputStream out = null;
        PrintWriter printWriter = null;

        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        try{

            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();

            String ckUploadPath = path + uid  + "_" + fileName;
            File folder = new File(path);

            if(!folder.exists()){
                try{
                    folder.mkdirs();
                }catch(Exception e){
                    e.getStackTrace();
                }
            }
            out = new FileOutputStream(new File(ckUploadPath));
            out.write(bytes);
            out.flush();

            String callback = request.getParameter("CKEditorFuncNum");
            printWriter = response.getWriter();
            //이미지 업로드 경로 추가(CKEditor)
            String fileUrl = "/customer/ckeditor/imgSubmit.do?uid=" + uid + "&fileName=" + fileName;
            String fileUrl_s = "http://devmultivm.ubcn.co.kr/detail?uid=" + uid + "&fileName=" + fileName;
            printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl_s+"\"}");
            printWriter.flush();

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
    public void setSubmitFile(String uid, String fileName, HttpServletResponse response, String path) throws IOException {
        String sDirPath = path + uid + "_" + fileName;
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

    public void downloadFile(String fileName, HttpServletResponse response, String path) throws IOException {
        File file = new File(path + fileName);
        response.setHeader("Content-Disposition", "attachment;filename=" + file.getName()); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더

        FileInputStream fileInputStream = new FileInputStream(path + fileName); // 파일 읽어오기
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
