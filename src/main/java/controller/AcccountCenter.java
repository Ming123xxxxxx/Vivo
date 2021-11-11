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

    @RequestMapping("pinformation")
    public String info(){
        return "acenter";
    }

    @ResponseBody
    @RequestMapping("pikeupinfo")
    public List pikeuoinfo(HttpSession session){
        List<String> list =new ArrayList<String>();
        Register reg= adminService.pikeupinformation((String)session.getAttribute("veri"));
        list.add(reg.getUsername());
        list.add(reg.getAccount());
        list.add(reg.getPwd());
        return list;
    }
}
