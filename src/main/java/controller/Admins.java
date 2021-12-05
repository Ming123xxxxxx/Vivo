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
import utils.Urls;

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
    Urls urls;

    @Autowired
    Redis redis;

    @RequestMapping("/toad")
    public String toad(HttpSession session,Model model){
        if((int)session.getAttribute("admin")==1) {
            List<Register> list = adminService.onandoff((int) session.getAttribute("onandoff"), (int) session.getAttribute("startindex"), (int) session.getAttribute("pagesize"));
            model.addAttribute("list", list);
            return "admin";
        }else{
            return "varifaction";
        }
    }

    @RequestMapping("/jump")
    public String jump(){
        return "varifaction";
    }

    @RequestMapping("/varis")
    public String varis(HttpSession session,String account,String pwd,Model model){
        if(adminInfoService.pikeupinformation(account,pwd)==1){
            adminInfoService.offtime(times.getymdhms(),account);
            session.setAttribute("admin",1);

            if (session.getAttribute("onandoff")==null){
                session.setAttribute("onandoff",0);
            }
            if (session.getAttribute("startindex")==null){
                session.setAttribute("startindex",0);
            }
            if (session.getAttribute("pagesize")==null){
                session.setAttribute("pagesize",10);
            }
        List<Register> list = adminService.onandoff((int)session.getAttribute("onandoff"), (int)session.getAttribute("startindex"), (int)session.getAttribute("pagesize"));

            model.addAttribute("list",list);
            return "admin";
        }else {
            session.setAttribute("admin",null);
            return "varifaction";
        }
    }

    @RequestMapping("/toadmin")
    public String td(HttpSession session,Model model){
        session.setAttribute("admin",1);

        List<Register> list = adminService.onandoff((int)session.getAttribute("onandoff"),(int)session.getAttribute("startindex"),(int)session.getAttribute("pagesize"));

        model.addAttribute("list",list);
        return "admin";
    }

    @ResponseBody
    @RequestMapping("on")
    public String on(HttpSession session,Model model){

        if (session.getAttribute("onandoff")==null){
            session.setAttribute("onandoff",0);
        }
        if (session.getAttribute("startindex")==null){
            session.setAttribute("startindex",0);
        }
        if (session.getAttribute("pagesize")==null){
            session.setAttribute("pagesize",10);
        }

        if((int)session.getAttribute("admin")==1){
            List<Register> list = adminService.onandoff((int)session.getAttribute("onandoff"), (int)session.getAttribute("startindex"), (int)session.getAttribute("pagesize"));
            model.addAttribute("list",list);
            return urls.admin();
        }else{
            return "0";
        }
    }


    @ResponseBody
    @RequestMapping("updatedata")
    public String updatedata(HttpSession session,String onandoff,String startindex,String pagesize){

        if (onandoff==null){
            session.setAttribute("onandoff",0);
        }else{
            session.setAttribute("onandoff",Integer.parseInt(onandoff.toString()));
        }

        if (startindex==null){
            session.setAttribute("startindex",0);
        }else{
            session.setAttribute("startindex",Integer.parseInt(startindex.toString()));
        }

        if (pagesize==null){
            session.setAttribute("pagesize",10);
        }else{
            session.setAttribute("pagesize",Integer.parseInt(pagesize.toString()));
        }
        return urls.toadmin();

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

    @RequestMapping("forcuoff")
    public String ea(String account,HttpSession session){
        adminService.onoffs(2,account);
        redis.setOffL(account);
        session.setAttribute(account,null);
        return "redirect:/admin/toadmin";
    }

    @RequestMapping("delus")
    public String delus(String account,HttpSession session){
        redis.delkey(account);
        adminService.userdel(account);
        session.setAttribute(account,null);
        return "redirect:/admin/toadmin";
    }
}
