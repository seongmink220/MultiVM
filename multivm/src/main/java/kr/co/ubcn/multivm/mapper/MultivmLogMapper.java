package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.MultivmLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MultivmLogMapper {
    public MultivmLog getLogInfo(int seq);
    public List<MultivmLog> getSearchLogList(Map<String, Object> map);
    public int insertLog(MultivmLog multivmLog);
    public int modifyLog(MultivmLog multivmLog);
    public int deleteLog(int seq);

}
