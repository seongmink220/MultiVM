package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class SalesProduct {
    public String transactionNo;
    public Integer seq;
    public String productCode;
    public Integer productPrice;
    public Integer count;
    public String shipResult;

    public String productName;
    public String vmId;
    public String terminalId;
    public String transactionDate;
    public String transactionTime;
    public Integer amount;
    public Integer slotNo;
    public String organizationName;
    public String companyName;
    public String place;

    public String receiveDate;
    public String payType;
    public String payStep;
    public String cancelDate;
    public String cancelTime;
}
