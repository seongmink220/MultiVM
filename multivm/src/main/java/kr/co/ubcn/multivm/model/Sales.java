package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Sales {
    public String transactionNo;
    public Integer companySeq;
    public Integer organizationSeq;
    public String vmId;
    public String terminalId;
    public String transactionDate;
    public String transactionTime;
    public String productCode;
    public Integer amount;
    public Integer slotNo;
    public Integer itemCount;

    public String receiveDate;
    public String payType;
    public String payStep;
    public String cancelDate;
    public String cancelTime;

    public String productName;
    public String sDate;
    public String eDate;
    public String organizationName;
    public String place;
    public Integer userSeq;


}
