package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class NoticeFile {
    public Integer seq;
    public Integer noticeSeq;
    public String fileName;
    public String fileRealName;
    public String fileSize;
}
