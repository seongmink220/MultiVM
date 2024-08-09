package kr.co.ubcn.multivm.mapper;


import kr.co.ubcn.multivm.model.Firmware;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FirmwareMapper {
    public Firmware getFirmwareInfo(int seq);
    public List<Firmware> getSearchFirmwareList(Map<String, Object> map);
    public int insertFirmware(Firmware event);
    //public void modifyAdv(Adv event);
    public void deleteFirmware(int seq);
    public boolean deleteFirmwareList(Map<String, Object> map);
    public boolean insertProgramToVM(Map<String, Object> map);
    public boolean deleteProgramToVM(Map<String, Object> map);

}
