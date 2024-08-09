package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class User {

    public Integer seq;
    public Integer companySeq;
    public Integer organizationSeq;
    public String id;
    public String password;
    public String name;
    public Integer auth;
    public String auth2;
    public String email;
    public String useYN;
    public String visible;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;

    //public String loginIp;
    public String companyName;
    public String organizationName;
    public Integer depth;
    public Integer parentSeq;
    public String page;
    //public boolean useCookie;

}
