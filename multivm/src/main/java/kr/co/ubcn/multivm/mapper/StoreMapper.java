package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Store;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface StoreMapper {
    public List<Store> getStoreList(Map<String, Object> map);
    public void deleteStoreList(int productSeq);
    public void deleteStoreList_v1(Map<String, Object> map);
    public void deleteStoreList_v2(Map<String, Object> map);
}
