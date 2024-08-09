package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.Company;
import kr.co.ubcn.multivm.model.Organization;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CompanyMapper {

    public Company getCompanyInfo(Integer seq);
    public String getCompanyName(Integer seq);
    public List<Company> getAllCompanyList();
    public List<Company> getAllCompanyList_admin();
    public void insertCompany(Company company);
    public void modifyCompany(Company company);
    public void deleteCompany(int companySeq);
    public void deleteCompany_v2(Map<String, Object> map);
    public List<Company> checkDupCompanyName(String name);

}
