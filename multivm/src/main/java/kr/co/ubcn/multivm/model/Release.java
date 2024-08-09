package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Release {
    public Integer seq;
    public Integer companySeq;
    public Integer organizationSeq;
    public Integer vmSeq;
    public Integer productSeq;
    public String releaseDate;
    public String releaseTime;
    public Integer productCount;
    public Integer editCount;
    public Integer slotNo;
    public String releaseType;

    public String vmId;
    public String terminalId;
    public String productName;
    public String productCode;
    public String sDate;
    public String eDate;
    public Integer modifyUserSeq;

    public String searchType;
    public String searchValue;


}
