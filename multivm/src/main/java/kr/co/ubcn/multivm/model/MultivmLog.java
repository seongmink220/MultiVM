package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class MultivmLog {

    public String vmId;
    public Integer seq;
    public Integer vmSeq;
    public String filePath;
    public String fileName; //리스트에 보여질 tit, log_날짜
    public String regDate; //자판기에 등록된 일시
    public String createDate; //서버DB에 저장된 일시
}
