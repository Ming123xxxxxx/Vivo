package service;

import mapper.AdminInfoMapper;
import mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.AdminInfo;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/1 19:27
 */
@Service
public class AdminInfoServiceImpl implements AdminInfoService{

    @Autowired
    AdminInfoMapper adminInfoMapper;

    public void setAdminInfoMapper(AdminInfoMapper adminInfoMapper){
        this.adminInfoMapper=adminInfoMapper;
    }


    @Override
    public int pikeupinformation(String account, String pwd) {
        return adminInfoMapper.pikeupinformation(account,pwd);
    }

    @Override
    public int offtime(String lastlogintime, String account) {
        return adminInfoMapper.offtime(lastlogintime,account);
    }
}
