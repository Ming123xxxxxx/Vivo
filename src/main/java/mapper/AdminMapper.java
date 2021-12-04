package mapper;

import org.apache.ibatis.annotations.Param;
import pojo.Register;

import java.util.List;

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

    int updateuser(@Param("username") String username, @Param("pwd") String pwd,@Param("modifytime") String modifytime,@Param("act") String act);

    int offtime(@Param("lastlogintime") String lastlogintime,@Param("account") String account);

    int onoffs(@Param("onoff") int onoff ,@Param("account") String account);

    List<Register> onandoff(@Param("onoff") int onoff,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize);
}