package kr.co.ubcn.multivm.mapper;

import kr.co.ubcn.multivm.model.LoginUser;
import kr.co.ubcn.multivm.model.User;
import kr.co.ubcn.multivm.model.VendingMachine;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserMapper {

    //public List<User> getOneUserList(User user);
    public User getOneUserList(User user);
    public User getUserInfoDetail(User user);
    public User getUserinfo(Map<String, Object> map);
    public void insertUser(User user);
    public void modifyUser(User user);
    //public void deleteUser(int seq);
    public List<User> getCompanyAllUserList(User user);
    public User idCheckDup(User user);
    public void updateOrgUser(Map<String, Object> map);
    public void deleteUser_v2(Map<String, Object> map);
    public void deleteUser_v3(Map<String, Object> map);
    public List<String> getUserVMList(Map<String, Object> map);
}
