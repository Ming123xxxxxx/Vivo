package controller;

import com.mysql.cj.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Register;
import service.AdminInfoService;
import service.AdminService;
import utils.Redis;
import utils.Times;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @Qualifier("AdminServiceImpl")
    private AdminService adminService;

    @Autowired
    Times times;

    @Autowired
    Redis redis;

    @RequestMapping("/jump")
    public String jump(){
        return "varifaction";
    }

    @RequestMapping("/varis")
    public String varis(HttpSession session,String account,String pwd,Model model){
        if(adminInfoService.pikeupinformation(account,pwd)==1){
            adminInfoService.offtime(times.getymdhms(),account);
            session.setAttribute("admin",1);
//            List list = new ArrayList();
//            Map map = new HashMap();
//            map.put("User_Online_Status",redis.OUser());
//            map.put("User_All_Status",redis.currentperson());
//            list.add(map);
            List<Register> list = adminService.onandoff(0, 0, 6);
//            for(Register reg:onandoff){
//                list.add(reg);
//            }
            model.addAttribute("list",list);
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

    @ResponseBody
    @RequestMapping("Onpepo")
    public Map onpeppo(Model model, int sel, int startIndex, int pageSize){

        List list = new ArrayList();
        Map map = new HashMap();
        map.put("User_Online_Status",redis.OUser());
        map.put("User_All_Status",redis.currentperson());
        list.add(map);
        List<Register> onandoff = adminService.onandoff(sel, startIndex, pageSize);
        for(Register reg:onandoff){
            list.add(reg);
        }
        model.addAttribute("list",list);
        return map;
    }
}
