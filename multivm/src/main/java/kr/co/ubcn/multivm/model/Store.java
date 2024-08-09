package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Store {
    public Integer seq;
    public Integer companySeq;
    public Integer organizationSeq;
    public Integer vmSeq;
    public Integer productSeq;
    public Integer productCount;
    public String storeDate;
    public String storeTime;
    public Integer slotNo;

    public String vmId;
    public String terminalId;
    public String productName;
    public String productCode;
    public String sDate;
    public String eDate;

    public String searchType;
    public String searchValue;
}
