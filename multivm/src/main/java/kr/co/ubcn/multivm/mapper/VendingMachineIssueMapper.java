package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.VendingMachineIssue;
import kr.co.ubcn.multivm.model.VendingMachineStatus;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface VendingMachineIssueMapper {
    public VendingMachineIssue getVMIssue(int vmSeq);
    public List<VendingMachineIssue> getVMIssueList(Map<String, Object> map);
    public boolean insertVMIssue(VendingMachineIssue vendingMachineIssue);
    public void deleteVMIssueList_v2(Map<String, Object> map);
}
