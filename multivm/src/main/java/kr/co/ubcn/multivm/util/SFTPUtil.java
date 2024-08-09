package kr.co.ubcn.multivm.util;

import com.jcraft.jsch.*;
import lombok.extern.slf4j.Slf4j;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.*;
import java.util.Vector;

@Slf4j
@Component
public class SFTPUtil {

    private Session session = null;
    private Channel channel = null;
    private ChannelSftp channelSftp = null;
    public static final int RATIO = 0;
    public static final int SAME = -1;

    @Value("${server.file.host}")
    private String host;

    @Value("${server.file.port}")
    private int port;

    @Value("${server.file.user}")
    private String userName;

    @Value("${server.file.password}")
    private String password;

    @Value("${server.file.uploadPath}")
    private String uploadPath;

    @Value("${server.file.downloadPath}")
    private String downloadPath;



    /**
     * 서버와 연결에 필요한 값들을 가져와 초기화 시킴
     *
     */
    public void init() {

        log.info("파일서버 init 접근: "+host);
        JSch jSch = new JSch();

        try {
            /*if(privateKey != null) {//개인키가 존재한다면
                jSch.addIdentity(privateKey);
            }*/
            session = jSch.getSession(userName, host, port);
            session.setPassword(password);
            /*if(privateKey == null && password != null) {//개인키가 없다면 패스워드로 접속
                session.setPassword(password);
            }*/

            // 프로퍼티 설정
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no"); // 접속 시 hostkeychecking 여부
            session.setConfig(config);
            session.connect();
            //sftp로 접속
            channel = session.openChannel("sftp");
            channel.connect();
        } catch (JSchException e) {
            e.printStackTrace();
        }

        channelSftp = (ChannelSftp) channel;
    }

    /**
     * 디렉토리 생성
     *
     * @param mkdirName 생성할 디렉토리명
     */
    public void mkdir(String mkdirName){
        SftpATTRS attrs = null;
        mkdirName = mkdirName.replace("/","");

        try{
            attrs = channelSftp.stat(uploadPath + mkdirName);
        } catch (SftpException e) {
            log.info(uploadPath + mkdirName +" not exist");
        }
        if (attrs ==null) {
            try {
                channelSftp.cd(uploadPath);
                channelSftp.mkdir(mkdirName);
            } catch (SftpException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 디렉토리( or 파일) 존재 여부
     * @param path 디렉토리 (or 파일)
     * @return
     */
    public boolean exists(String path) {
        Vector res = null;
        try {
            res = channelSftp.ls(uploadPath + path);
        } catch (SftpException e) {
            if (e.id == ChannelSftp.SSH_FX_NO_SUCH_FILE) {
                return false;
            }
        }
        return res != null && !res.isEmpty();
    }

    /**
     * 파일 업로드
     *
     * @param dir 저장할 디렉토리('/'포함)
     * @param multipartFile 저장할 파일
     * @return 업로드 여부
     */
    public boolean upload(String dir, MultipartFile multipartFile, String fileName) throws IOException {

        File file = new File(multipartFile.getOriginalFilename());
        multipartFile.transferTo(file);
        // 파일 이름
        String name = fileName.equals("")?file.getName():fileName;
        String suffix = name.substring(name.lastIndexOf('.') + 1).toLowerCase();

        //이미지면 리사이징
        if ((suffix.equals("jpg") || suffix.equals("png") || suffix.equals("gif") || suffix.equals("jpeg"))&&multipartFile.getSize()>=1048576) {
            BufferedImage bi = ImageIO.read(file);
            // 2023-02-03. 이미지 색상 버그로 인해 바꿈
            //bi = Scalr.resize(bi, Scalr.Method.AUTOMATIC, 500, 500, Scalr.OP_ANTIALIAS);
            //ImageIO.write(bi,"jpg",file);
            resizeImage(file, 350,350);

            System.out.println("@@ 리사이징 결과: "+file.length());
        }


        System.out.println("@ 파일크기: "+multipartFile.getSize());

        boolean isUpload = false;
        SftpATTRS attrs;
        FileInputStream in = null;
        try {
            in = new FileInputStream(file);
            channelSftp.cd(uploadPath + dir);
            channelSftp.put(in, name);
            // 업로드했는지 확인
            if (this.exists(uploadPath + dir + name)) {
                isUpload = true;
                log.info("@@@ 파일업로드 완료. "+name);
            }
            if (in!=null) {
                isUpload = true;
                log.info("@@ 파일업로드 완료. "+name);

            }
        } catch (SftpException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                in.close();
                file.delete();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return isUpload;
    }

    /**
     * 파일 다운로드
     *
     * @param dir 다운로드 할 디렉토리
     * @param downloadFileName 다운로드 할 파일
     * @param path 다운로드 후 로컬에 저장될 경로(파일명)
     */
    public void download(String dir, String downloadFileName, String path) {
        InputStream in = null;
        FileOutputStream out = null;
        try {
            channelSftp.cd(uploadPath + dir);
            in = channelSftp.get(downloadFileName);
        } catch (SftpException e) {
            e.printStackTrace();
        }

        try {
            out = new FileOutputStream(new File(path));
            int i;

            while ((i = in.read()) != -1) {
                out.write(i);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                out.close();
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 파일 삭제
     */
    public boolean delete(String dir, String fileName){
        try {
            channelSftp.rm(uploadPath + dir + fileName);
            log.info("@@@ 파일 삭제 완료. "+uploadPath + dir + fileName);
        }catch (SftpException e){
            System.out.println("파일 존재하지 않아 삭제불가: "+uploadPath + dir + fileName);
        }
        return true;
    }

    /**
     * 연결 종료
     */
    public void disconnection() {
        channelSftp.quit();
        session.disconnect();
        log.info("파일서버 disconnection: "+host);
    }

    public static void resizeImage(File src, int width, int height) throws IOException {
        Image srcImg = null;
        String suffix = src.getName().substring(src.getName().lastIndexOf('.') + 1).toLowerCase();
        if (suffix.equals("jpg") || suffix.equals("png") || suffix.equals("gif") || suffix.equals("jpeg")) {
            srcImg = ImageIO.read(src);
        } else {
            // BMP가 아닌 경우 ImageIcon을 활용해서 Image 생성
            // 이렇게 하는 이유는 getScaledInstance를 통해 구한 이미지를
            // PixelGrabber.grabPixels로 리사이즈 할때 빠르게 처리하기 위함이다.
            srcImg = new ImageIcon(src.toURL()).getImage();
        }

        int srcWidth = srcImg.getWidth(null);
        int srcHeight = srcImg.getHeight(null);

        int destWidth = -1, destHeight = -1;

        if (width == SAME) {
            destWidth = srcWidth;
        } else if (width > 0) {
            destWidth = width;
        }

        if (height == SAME) {
            destHeight = srcHeight;
        } else if (height > 0) {
            destHeight = height;
        }

        if (width == RATIO && height == RATIO) {
            destWidth = srcWidth;
            destHeight = srcHeight;
        } else if (width == RATIO) {
            double ratio = ((double) destHeight) / ((double) srcHeight);
            destWidth = (int) ((double) srcWidth * ratio);
        } else if (height == RATIO) {
            double ratio = ((double) destWidth) / ((double) srcWidth);
            destHeight = (int) ((double) srcHeight * ratio);
        }

        Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight, Image.SCALE_SMOOTH);
        int pixels[] = new int[destWidth * destHeight];
        PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth, destHeight, pixels, 0, destWidth);
        try {
            pg.grabPixels();
        } catch (InterruptedException e) {
            throw new IOException(e.getMessage());
        }
        BufferedImage destImg = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB);
        destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);

        ImageIO.write(destImg, "jpg", src);
    }






}

