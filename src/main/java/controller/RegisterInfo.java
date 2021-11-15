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
 * @date 2021/11/4 9:10
 */
@Controller
@RequestMapping("/registerinfo")
public class RegisterInfo {

    //在所有界面层，一定会有业务逻辑层的对象
    @Autowired
    @Qualifier("AdminServiceImpl")
    private AdminService adminService;

    @RequestMapping("register")
    public String register(){
        return "register";
    }

    @RequestMapping("index")
    public String index(){
        return "index";
    }

    @RequestMapping("adduser")
    public String adduser(String username, String account, String pwd, HttpSession session) {
        if(session.getAttribute("veri")==null||"fail".equals(session.getAttribute("veri"))){
            Register register = new Register(username,account,pwd);
            adminService.adduser(register);
        }else {
             int p=adminService.updateuser(username,account,pwd,(String)session.getAttribute("veri"));
             if(p>0){
                 session.setAttribute("veri",account);
             }
        }
        return "index";
    }

    @ResponseBody
    @RequestMapping("/varifaction")
    public List var(String name, String act, String pwd, String rpwd){
        Map map =new HashMap();
        Map map1 =new HashMap();
        Map map2 =new HashMap();
        Map map3=new HashMap();
        List<Map> list = new ArrayList<Map>();

        if(name!=null){
            if(name.length()<6&&name.length()>0){
                    map.put("color", "aquamarine");
                    map.put("text", "√");
            }else{
                map.put("color","#ea8585");
                map.put("text","请输入小于6位的名字");
            }
        } else if(name==null){
            map.put("color","#ea8585");
            map.put("text","请输入小于6位的名字");
        }

        if(act!=null){
            if(act.length()==11){
                if(adminService.queryone(act)>0){
                    map1.put("color", "#ea8585");
                    map1.put("text", "此账号已被注册");
                }else {
                    int p=0;
                    for(int l=act.length()-1;l>=0;l--){
                        if(Character.isDigit(act.charAt(l))==true){
                            p++;
                        }
                    }
                    if(p==act.length()) {
                        map1.put("color", "aquamarine");
                        map1.put("text", "√");
                    }else {
                        map1.put("color", "#ea8585");
                        map1.put("text", "账号中只能有数字");
                    }
                }
            }else{
                map1.put("color","#ea8585");
                map1.put("text","请输入11数字位账号");
            }
        }else{
            map1.put("color","#ea8585");
            map1.put("text","请输入11位数字账号");
        }

        if(pwd!=null){
            if(pwd.length()<=11&&pwd.length()>6){
                map2.put("color","aquamarine");
                map2.put("text","√");
            }else{
                map2.put("color","#ea8585");
                map2.put("text","密码需要>6位&&<12位");
            }
        }else{
            map2.put("color","#ea8585");
            map2.put("text","密码需要>6位&&<12位");
        }

        if(pwd!=null&&rpwd!=null){
            if(rpwd.equals(pwd)){
                map3.put("color","aquamarine");
                map3.put("text","√");
            }else{
                map3.put("color","#ea8585");
                map3.put("text","与密码不相等");
            }
        }else{
            map3.put("color","#ea8585");
            map3.put("text","与密码不相等");
        }

        list.add(map);
        list.add(map1);
        list.add(map2);
        list.add(map3);

        return list;
    }
}
