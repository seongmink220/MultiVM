package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class VendingMachine {

    public Integer seq;
    public Integer companySeq;
    public String companyName;
    public Integer organizationSeq;
    public String organizationName;
    public Integer userSeq;
    public String userName;
    public String userId;
    public String vmId;
    public String terminalId;
    public String place;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;
    public String currVersion;
    public Integer firmwareSeq;
    public String firmwareStatus;
    public Integer advSeq;
    public Integer auth;
    public String visible;
    public String vmModel;

}
