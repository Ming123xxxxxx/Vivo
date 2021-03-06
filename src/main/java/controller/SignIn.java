package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.AdminService;
import utils.MD5Util;
import utils.Redis;
import utils.Times;
import utils.Urls;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/11/4 15:25
 */
@Controller
@RequestMapping("/log")
public class SignIn {
    //在所有界面层，一定会有业务逻辑层的对象
    @Autowired
    @Qualifier("AdminServiceImpl")
    private AdminService adminService;

    @Autowired
    private MD5Util md5Util;

    @Autowired
    private Times times;

    @Autowired
    Urls urls;

    @Autowired
    Redis redis;

    @RequestMapping("on")
    public String on(){
        return "sign";
    }

    @ResponseBody
    @RequestMapping("/ver")
    public List ver(String account, String pwd, String code,HttpSession session){
        List list =new ArrayList();
        String suc=urls.acenter();
        String def=null;
        String s="000";
        String noac="001";
        String noco="002";
        if(session.getAttribute(KAPTCHA_SESSION_KEY).equals(code)){
            if(adminService.queryaccount(account,md5Util.getMD5(pwd))==1){
                redis.setOnL(account);
                list.add(suc);
                list.add(s);
                session.setAttribute("veri",account);
                //登录成功则设置对应的时间的session
                session.setAttribute("years",times.gety());
                session.setAttribute("months",times.getm());
                session.setAttribute("days",times.getd());
                adminService.offtime(times.getymdhms(),account);
                adminService.onoffs(1,account);
                return list;
            }else{
                list.add(def);
                list.add(noac);
                session.setAttribute("veri",account);
                return list;
            }
        }else{
                list.add(def);
                list.add(noco);
                session.setAttribute("veri",account);
                return list;
        }
    }
}
