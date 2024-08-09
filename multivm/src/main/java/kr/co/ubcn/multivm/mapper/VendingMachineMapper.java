package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.User;
import kr.co.ubcn.multivm.model.VendingMachine;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface VendingMachineMapper {
    public List<VendingMachine> getSearchVM(Map<String, Object> map);
    public List<VendingMachine> getSearchVM2(Map<String, Object> map);
    public VendingMachine getUserVM(Map<String, Object> map);
    public List<VendingMachine> getUserVMList(Map<String, Object> map);
    public List<VendingMachine> getSearchVMList(VendingMachine vendingMachine);
    public void insertVM(VendingMachine vendingMachine);
    public void modifyVM(VendingMachine vendingMachine);
    public void deleteVM(int seq);
    public int isHasVMId(Map<String, Object> map);
    public int isHasTerminalId(Map<String, Object> map);

    public void updateVMModifyDate(int seq);
    public List<VendingMachine> getVMOfOrgList(Map<String, Object> map);
    public List<VendingMachine> getAdvSearchVMList(Map<String, Object> map);
    public void deleteVM_v2(Map<String, Object> map);
    public void deleteVM_v3(Map<String, Object> map);
    // 2023-02-03. 소속 또는 조직 삭제시 등록된 단말기 있는지 체크
    public List<VendingMachine> isCheckUseVM(Map<String, Object> map);
}
