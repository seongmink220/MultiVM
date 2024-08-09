package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class VendingMachineAdv {

    public Integer vmSeq;
    public Integer advSeq;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;
    public String vmId;
    public String organizationName;
    public String companyName;
    public String advTitle;
    public String place;
    public String advOwner;
    public String advFile;
    public String advType;
    public String originFile;

}
