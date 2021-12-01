package mapper;

import org.apache.ibatis.annotations.Param;
import pojo.AdminInfo;
import pojo.Register;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/1 19:21
 */
public interface AdminInfoMapper {
    int pikeupinformation(@Param("account") String account,@Param("pwd") String pwd);
    int offtime(@Param("lastlogintime") String lastlogintime,@Param("account") String account);
}
