package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class VendingMachineCurrProduct {

    public Integer vmSeq;
    public Integer slotNo;
    public Integer productCount;
    public String enable;
    public String productCode;
    public String productName;
    public String productImage;
    public String productDetail;
    public Integer productPrice;
    public String isGlass;


    public Integer companySeq;
    public String companyName;
    public Integer organizationSeq;
    public String organizationName;
    public String vmId;
    public String place;
    public String modifyDate;
}
