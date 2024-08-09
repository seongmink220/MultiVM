package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.VendingMachineStatus;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface VendingMachineStatusMapper {
    public VendingMachineStatus getVMStatus(int vmSeq);
    public List<VendingMachineStatus> getVMStatusList(Map<String, Object> map);
    public boolean insertVMStatus(VendingMachineStatus vendingMachineInfo);
    public void deleteVMStatusList_v2(Map<String, Object> map);
}
