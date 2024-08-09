package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Firmware {
    public Integer seq;
    public String currVersion;
    public String content;
    public String fileName;
    public String sha256; //파일이름은
    public String createDate;
    public Integer createUserSeq;
}
