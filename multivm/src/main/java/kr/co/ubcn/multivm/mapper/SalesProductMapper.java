package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Sales;
import kr.co.ubcn.multivm.model.SalesProduct;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SalesProductMapper {

    public List<SalesProduct> getSalesDetail(SalesProduct salesProduct);
    public List<SalesProduct> getDeadlineSalesData(Sales sales);
}
