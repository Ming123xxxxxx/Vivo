package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.AdminService;
import utils.Redis;

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

    @ResponseBody
    @RequestMapping("ea")
    public void ea(HttpSession session){
        redis.setOffL((String)session.getAttribute("veri"));
        session.setAttribute("veri",null);
    }
}
