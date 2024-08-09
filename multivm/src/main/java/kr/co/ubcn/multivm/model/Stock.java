package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Stock {
    public Integer seq;
    public Integer companySeq;
    public Integer organizationSeq;
    public Integer vmSeq;
    public Integer productSeq;
    public Integer productCount;
    public Integer slotNo;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;

    public String vmId;
    public String terminalId;
    public String productName;
    public String productCode;

}
