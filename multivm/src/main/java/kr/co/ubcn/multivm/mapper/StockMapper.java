package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Release;
import kr.co.ubcn.multivm.model.Stock;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface StockMapper {
    public boolean insertStock(Map<String, Object> map);
    public List<Stock> getStockList(Map<String, Object> map);
    public List<Stock> getStockList_v2(Map<String, Object> map);
    public Stock getStockInfo(Map<String, Object> map);
    public void deleteStockList(Map<String, Object> map);
    public void deleteStockList_v1(Map<String, Object> map);
    public boolean updateSlotProductStock(Map<String, Object> map);
    public void deleteStockList_v2(Map<String, Object> map);
    public boolean updateStock(Release release);

}
