package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Adv;
import kr.co.ubcn.multivm.model.VendingMachineAdv;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AdvMapper {
    public Adv getAdvInfo(int seq);
    public List<Adv> getSearchAdvList(Map<String, Object> map);
    public List<Adv> getVMAdvList(Map<String, Object> map);
    public int insertAdv(Adv adv);
    public int modifyAdv(Adv adv);
    public void deleteAdv(Map<String, Object> map);
    public void insertVMAdv(VendingMachineAdv vendingMachineAdv);
    public void deleteVMAdv(VendingMachineAdv vendingMachineAdv);
    public int insertVMAdv_v2(List<VendingMachineAdv> list);
    public List<VendingMachineAdv> getVMAdvList2(Map<String, Object> map);
    public boolean deleteAdvFromVM(Map<String, Object> map);
    public boolean deleteVMFromAdv(Map<String, Object> map);
    public List<VendingMachineAdv> checkDupAdv(VendingMachineAdv vendingMachineAdv);
    public String checkUseAdvFile(int seq);

    public int updateAdv(Adv adv);
}
