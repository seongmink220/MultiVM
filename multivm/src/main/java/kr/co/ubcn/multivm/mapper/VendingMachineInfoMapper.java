package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.VendingMachineInfo;
import kr.co.ubcn.multivm.model.VendingMachineStatus;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface VendingMachineInfoMapper {
    public VendingMachineInfo getVMInfo(int vmSeq);
    public List<VendingMachineInfo> getVMInfoList(Map<String, Object> map);
    public boolean insertVMInfo(VendingMachineInfo vendingMachineInfo);
    public boolean insertVMInfo_v2(String vmId);
    public boolean updateVMActionData(VendingMachineInfo vendingMachineInfo);
    public void deleteVMInfoList_v2(Map<String, Object> map);

}
