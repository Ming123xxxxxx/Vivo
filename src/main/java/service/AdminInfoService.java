package service;

import org.apache.ibatis.annotations.Param;
import pojo.AdminInfo;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/1 19:28
 */
public interface AdminInfoService {
    int pikeupinformation(String account,String pwd);
    int offtime(String lastlogintime,String account);
}
