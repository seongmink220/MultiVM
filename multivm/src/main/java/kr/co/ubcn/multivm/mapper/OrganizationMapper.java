package kr.co.ubcn.multivm.mapper;

import com.sun.org.apache.xpath.internal.operations.Or;
import kr.co.ubcn.multivm.model.Organization;
import kr.co.ubcn.multivm.model.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface OrganizationMapper {

    //public List<Organization> getOrganizationInfo(Integer seq);
    public Organization getOrganizationInfo(User user);
    public List<Organization> getOrganizationList(Map<String, Object> map);
    public List<Organization> getDefaultOrig(User user);
    public List<Organization> getDefaultOrig2(Map<String, Object> map);
    public void insertOrg(Organization organization);
    public void modifyOrg(Organization organization);
    public void deleteOrg(Map<String, Object> map);
    public void deleteOrg_v2(Map<String, Object> map);

    public List<Organization> getOrgOfComList(Map<String, Object> map);
    public void deleteEventOfOrg(Map<String, Object> map);
    public List<Organization> checkDupOrgName(Organization organization);
}
