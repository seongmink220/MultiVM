package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Sales;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SalesMapper {
    public List<Sales> getSalesList(Map<String, Object> maps);
    public List<Sales> getDailySalesList(Map<String, Object> maps);
    public List<Sales> getDailySalesProductList(Map<String, Object> maps);
    public List<Sales> getIndexSalesList(Sales sales);
    public int getIndexAmount(Sales sales);
    public List<Sales> getIndexWeeklyAmount(Sales sales);
    public List<Sales> checkTransactionNo(String transactionNo);
}
