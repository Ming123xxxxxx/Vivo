package controller;

import com.mysql.cj.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.AdminInfoService;
import utils.Times;

import javax.servlet.http.HttpSession;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/1 18:44
 */
@Controller
@RequestMapping("/admin")
public class Admins {

    @Autowired
    @Qualifier("AdminInfoServiceImpl")
    AdminInfoService adminInfoService;

    @Autowired
    Times times;

    @RequestMapping("/jump")
    public String jump(){
        return "varifaction";
    }

    @RequestMapping("/varis")
    public String varis(HttpSession session,String account,String pwd){
        if(adminInfoService.pikeupinformation(account,pwd)==1){
            adminInfoService.offtime(times.getymdhms(),account);
            session.setAttribute("admin",1);
            return "admin";
        }else {
            session.setAttribute("admin",null);
            return "varifaction";
        }
    }

    @ResponseBody
    @RequestMapping("on")
    public String on(HttpSession session){
        if((int)session.getAttribute("admin")==1){
            return "1";
        }else{
            return "0";
        }

    }
}
