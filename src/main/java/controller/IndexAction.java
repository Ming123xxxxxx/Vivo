package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Register;
import service.AdminService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/10/29 19:12
 */
@Controller
@RequestMapping("/homepage")
public class IndexAction {

    //在所有界面层，一定会有业务逻辑层的对象
    @Autowired
    @Qualifier("AdminServiceImpl")
    private AdminService adminService;

    @RequestMapping("index")
    public String index(){
        return "index";
    }

    @ResponseBody
    @RequestMapping("dact")
    public String dact(HttpSession session){
        if(null==session.getAttribute("veri")||"fail".equals(session.getAttribute("veri"))){
            return "http://localhost:8080/Vivo_war_exploded/";
        }else{
            return "0";
        }
    }

}
