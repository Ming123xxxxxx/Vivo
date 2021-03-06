package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.AdminService;
import utils.Redis;
import utils.Urls;

import javax.servlet.http.HttpSession;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/11/7 21:02
 */
@Controller
@RequestMapping("exitac")
public class Exit {

    @Autowired
    @Qualifier("AdminServiceImpl")
    AdminService adminService;

    @Autowired
    Redis redis;

    @Autowired
    Urls urls;

    @ResponseBody
    @RequestMapping("ea")
    public String ea(HttpSession session){
        if(session.getAttribute("veri")!=null&&adminService.pikeupinformation((String)session.getAttribute("veri")).getOnoff()==1) {
            adminService.onoffs(2, (String) session.getAttribute("veri"));
            redis.setOffL((String) session.getAttribute("veri"));
            session.setAttribute("veri", null);
            return urls.index();
        }else{
            return "2";
        }
    }

}
