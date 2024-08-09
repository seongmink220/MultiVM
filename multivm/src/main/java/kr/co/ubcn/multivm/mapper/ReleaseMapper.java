package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Release;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReleaseMapper {
    public boolean insertRelease(Release release);
    public List<Release> getReleaseList(Map<String, Object> map);
    public void deleteReleaseList(int productSeq);
    public void deleteReleaseList_v1(Map<String, Object> map);
    public void deleteReleaseList_v2(Map<String, Object> map);
}
