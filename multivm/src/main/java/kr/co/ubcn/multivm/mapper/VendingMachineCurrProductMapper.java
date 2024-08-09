package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.VendingMachineCurrProduct;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface VendingMachineCurrProductMapper {
    public VendingMachineCurrProduct getSearchVMCurrProduct(Map<String, Object> map);
    public List<VendingMachineCurrProduct> getVMCurrProductList(Map<String, Object> map);
    public List<VendingMachineCurrProduct> getVMCurrProductFloor0(int vmSeq);
    public boolean deleteSlotInfo(int vmSeq);
    public boolean insertSlotInfo(List<VendingMachineCurrProduct> list);
    public void deleteSlotInfo_v2(Map<String, Object> map);
    public boolean setSlotEnable(Map<String, Object> map);
}
