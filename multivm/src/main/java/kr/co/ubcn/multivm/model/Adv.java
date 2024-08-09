package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Adv {
    public Integer seq;
    public Integer companySeq;
    public Integer organizationSeq;
    public String advTitle;
    public String advContent;
    public String advOwner;
    public String advFile;
    public String advType;
    public String originFile;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;

    public String organizationName;
    public String companyName;
    public String vmId;
}
