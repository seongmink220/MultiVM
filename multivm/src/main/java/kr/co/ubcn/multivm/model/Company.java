package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Company {

    public Integer seq;
    public String name;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;
}
