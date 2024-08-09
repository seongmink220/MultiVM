package kr.co.ubcn.multivm.model;

import lombok.Data;

@Data
public class VendingMachineInfo {

    public Integer vmSeq;
    public Integer companySeq;
    public Integer organizationSeq;
    public String organizationName;
    public String vmId;
    public String terminalId;
    public String place;
    public String useTemper;
    public Integer setTemper;
    public Integer led;
    public String antiFog;
    public String tel;
    public String updateDate;
    public String actionData;
    public String modifyDate;
}
