package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Register;
import service.AdminService;
import utils.MD5Util;
import utils.Redis;
import utils.Urls;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/11/7 16:17
 */
@Controller
@RequestMapping("/atcenter")
public class AcccountCenter {

    @Autowired
    @Qualifier("AdminServiceImpl")
    AdminService adminService;

    @Autowired
    Redis redis;

    @Autowired
    Urls urls;

    @RequestMapping("pinformation")
    public String info(){
        return "acenter";
    }

    @ResponseBody
    @RequestMapping("toacenter")
    public String toacenter(){
        return urls.acenter();
    }

    @ResponseBody
    @RequestMapping("pikeupinfo")
    public List pikeuoinfo(HttpSession session){
        List<String> list =new ArrayList<String>();
        Register reg= adminService.pikeupinformation((String)session.getAttribute("veri"));
        try {
            list.add(reg.getUsername());
            list.add(reg.getAccount());
            String p="";
            for(int i=0;i<reg.getPwd().length();i++){
                p +="*";
            }
            list.add(p);
        }catch (NullPointerException e){
            return list;
        }
        return list;
    }

    @ResponseBody
    @RequestMapping("deluser")
    public String deluser(HttpSession session,String upact){
        String account=(String)session.getAttribute("veri");
         if(adminService.getpwd(account).equals(MD5Util.getMD5(upact))){
            redis.delkey((String)session.getAttribute("veri"));
            adminService.userdel(account);
            session.setAttribute("veri",null);
            return urls.index();
         }else{
            return "0";
         }
    }

    @ResponseBody
    @RequestMapping("upuser")
    public String upuser(HttpSession session,String upact){
        String account=(String)session.getAttribute("veri");
        if(adminService.getpwd(account).equals(MD5Util.getMD5(upact))){
            return urls.register();
        }else{
            return "0";
        }
    }
}
