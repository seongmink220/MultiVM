package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class Notice {
    public Integer seq;
    public String title;
    public String content;
    public String createDate;
    public Integer createUserSeq;
    public String modifyDate;
    public Integer modifyUserSeq;
    public Integer file1;
    public Integer file2;
    public Integer file3;
    public Integer file4;

    public String type;
}
