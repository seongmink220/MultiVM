package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Notice;
import kr.co.ubcn.multivm.model.NoticeFile;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface NoticeMapper {
    public Notice getNoticeInfo(Integer seq);
    public List<Notice> getNoticePrevAndNext(Integer seq);
    public List<Notice> getNoticeList(Map<String, Object> map);
    public void insertNotice(Notice notice);
    public void updateNotice(Notice notice);
    public void deleteNotice(int seq);
    public List<NoticeFile> getNoticeFileList(Integer noticeSeq);
    public int getNewNotice();
    public int insertNoticeFile(NoticeFile noticeFile);
    public void deleteNoticeFile(Map<String, Object> map);
    public int getCountNoticeFile(int noticeSeq); //파일개수
    //파일체크 ( 실제이름과 사이즈 )
}
