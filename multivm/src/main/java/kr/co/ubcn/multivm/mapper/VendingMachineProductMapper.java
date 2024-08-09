package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Product;
import kr.co.ubcn.multivm.model.VendingMachineProduct;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface VendingMachineProductMapper {
    public List<VendingMachineProduct> getVMProductList(Map<String, Object> map);
    public VendingMachineProduct getVMProductInfo(Map<String, Object> map);
    public VendingMachineProduct getVMProduct(Map<String, Object> map);
    public void deleteVMProduct(Map<String, Object> map);
    public void insertVMProduct(VendingMachineProduct vendingMachineProduct);
    List<String> isHasCodeVMProductCode(Map<String, Object> map);
    void modifyVMProduct(VendingMachineProduct vendingMachineProduct);
    void deleteVMProduct_v1(Map<String, Object> map);
    VendingMachineProduct isHasCodeVMProductCode_v1(Map<String, Object> map);

    void deleteVMProduct_v2_deleted(Map<String, Object> map);

    List<VendingMachineProduct> getEventVMProductList(Map<String, Object> map);
    boolean updateEventVMProduct(Map<String, Object> map);
    List<VendingMachineProduct> getVMProductList2(Map<String, Object> map);
    public void deleteVmProduct_v2(Map<String, Object> map);
    public void updateVMProductModifyDate(Product product);

}
