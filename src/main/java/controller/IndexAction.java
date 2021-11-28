package controller;

import com.mysql.cj.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Register;
import service.AdminService;
import utils.Redis;
import utils.Times;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
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

    @Autowired
    Times times;

    @Autowired
    Redis redis;

    @RequestMapping("index")
    public String index(){
        return "index";
    }
//    @ResponseBody
//    @RequestMapping("gs")
//    public String gs(HttpSession session){
//        return session.getAttribute(account);
//    }

    @ResponseBody
    @RequestMapping("dact")
    public String dact(HttpSession session){
        if(null==session.getAttribute("veri")||"fail".equals(session.getAttribute("veri"))){
            return "http://localhost:8080/Vivo_war_exploded/";
        }else{
            return "0";
        }
    }

    @ResponseBody
    @RequestMapping("attendance")
    public List attendence(String swicths,HttpSession session) throws ParseException {

        int years=(int)session.getAttribute("years");
        int months=(int)session.getAttribute("months");
        if(swicths!=null){

            if(swicths.equals("-1")){
                if(months==1){
                    years=years-1;
                    months=12;
                }else{
                    months=months-1;
                }
            }else if(swicths.equals("1")){
                if(months==12){
                    years=years+1;
                    months=1;
                }else{
                    months=months+1;
                }
            }
        }

        session.setAttribute("years",years);
        session.setAttribute("months",months);

        //获取当前年月的1号为星期几
        int monthesWeek = times.getMonthesWeek(years,months);
        //获取当前年当前月为几天
        int numberDays = times.getNumberDays(years,months);

        //获取日历切换的当前时间与注册时间的间隔天数
        int intervel = times.getTimeIntervel((adminService.pikeupinformation((String)session.getAttribute("veri"))).getRegdate(),years+"-"+months+"-"+times.getd());

//       if(swicths!=null){
//           if(swicths.equals("-1")){
//               if((times.getm()>(int)session.getAttribute("months")&&times.gety()==(int)session.getAttribute("years"))||times.gety()>(int)session.getAttribute("years")){
//                   session.setAttribute("offset", (int)session.getAttribute("offset")-numberDays);
//               }
//           }else if(swicths.equals("1")){
//               if((times.getm()>(int)session.getAttribute("months")&&times.gety()==(int)session.getAttribute("years"))||times.gety()>(int)session.getAttribute("years")){
//                   session.setAttribute("offset", (int)session.getAttribute("offset")+numberDays);
//               }
//           }
//       }else{
//
//       }
        session.setAttribute("offset",intervel-times.getd());
        //获取当前日历的所有信息
        List ainfo = redis.getMonthsArrendance((String) session.getAttribute("veri"), (int)session.getAttribute("offset"), years, months, numberDays, monthesWeek);

        return ainfo;

    }

    @ResponseBody
    @RequestMapping("currenttime")
    public List currenttime(HttpSession session){
        List list = new ArrayList();
        int d=00;
        int y=(int)session.getAttribute("years");
        int m=(int) session.getAttribute("months");
        if(y!=times.gety()||(y==times.gety()&&m!=times.getm())){
            d=01;
        }else {
            d = (int) session.getAttribute("days");
        }
        list.add(y);
        list.add(m);
        list.add(d);
        return list;
    }

    @ResponseBody
    @RequestMapping("cus")
    public void cus(HttpSession session){
        //登录成功则设置对应的时间的session
        session.setAttribute("years",times.gety());
        session.setAttribute("months",times.getm());
        session.setAttribute("days",times.getd());
    }

}
