package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Code;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CodeMapper {

    public List<Code> getCodeList(Map<String, Object> map);
    public int checkDupCode(Code code);
    public int insertCode(Code code);
    public int modifyCode(Code code);

}
