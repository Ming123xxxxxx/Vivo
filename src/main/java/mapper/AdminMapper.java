package mapper;

import org.apache.ibatis.annotations.Param;
import pojo.Register;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/10/30 21:21
 */
public interface AdminMapper {
    int adduser(Register register);

    int queryone(@Param("account") String account);

    int queryaccount(@Param("account") String account, @Param("pwd") String pwd);

    Register pikeupinformation(@Param("account") String account);

    int userdel(@Param("account") String account);

    String getpwd(@Param("account") String account);

    int updateuser(@Param("username") String username,@Param("account") String account, @Param("pwd") String pwd,@Param("act") String act);
}