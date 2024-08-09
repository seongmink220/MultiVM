package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Organization {

    public Integer seq;
    public Integer organizationSeq;
    public String organizationName;
    public Integer companySeq;
    public String companyName;
    public String name;
    public Integer depth;
    public Integer parentSeq;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;
    public String visible;

}
