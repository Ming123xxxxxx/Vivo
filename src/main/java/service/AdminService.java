package service;

import org.apache.ibatis.annotations.Param;
import pojo.Register;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/10/30 21:33
 */
public interface AdminService {
    int adduser(Register register);
    int queryone(String account);
    int queryaccount(String account,String pwd);
    Register pikeupinformation(String account);
    int userdel(String account);
    String getpwd(String account);
    int updateuser(String username,  String pwd, String modifytime,String act);
    int offtime(String lastlogintime,String account);
}
