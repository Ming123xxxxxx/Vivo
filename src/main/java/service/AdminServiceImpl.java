package service;

import mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.*;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/10/30 21:32
 */
@Service
public class AdminServiceImpl  implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    public void setAdminMapper(AdminMapper adminMapper){
        this.adminMapper=adminMapper;
    }

    @Override
    public int adduser(Register register) {
      return adminMapper.adduser(register);
    }

    @Override
    public int queryone(String account) {
        return adminMapper.queryone(account);
    }

    @Override
    public int queryaccount(String account, String pwd) {
        return adminMapper.queryaccount(account,pwd);
    }

    @Override
    public Register pikeupinformation(String account) {
        return adminMapper.pikeupinformation(account);
    }

    @Override
    public int userdel(String account) {
        return adminMapper.userdel(account);
    }

    @Override
    public String getpwd(String account) {
        return adminMapper.getpwd(account);
    }
}
