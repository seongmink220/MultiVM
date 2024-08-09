package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class VendingMachineProduct {

    public Integer vmSeq;
    public Integer slotNo;
    public String productCode;
    public String productName;
    public Integer productCount;
    public Integer productPrice;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;
    public String productImage;
    public String productDetail;
    public String isGlass;
    public String visible;
    public Integer eventSeq;

    public String eventTitle;
    public String eventContent;
    public String eventType;
    public Integer eventData;
    public String eventStartTime;
    public String eventEndTime;
    public Integer eventPrice;
    public Integer discount;

    public String companyName;
    public String organizationName;
    public String place;
    public Integer organizationSeq;
    public String vmId;
}
