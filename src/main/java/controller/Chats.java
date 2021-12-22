package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.ChatPojo;
import service.AdminService;
import service.ChatService;
import utils.Times;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/21 16:08
 */
@Controller
@RequestMapping("/chartsroom")
public class Chats {

    @Autowired
    @Qualifier("ChatServiceImpl")
    ChatService chatService;

    @Autowired
    @Qualifier("AdminServiceImpl")
    AdminService adminService;

    @Autowired
    Times times;

    @RequestMapping("into")
    public String into(HttpSession session, Model model){
        session.setAttribute("NumberOfChats",chatService.getlastid());
        List<ChatPojo>  chats= new ArrayList<>();
        List<ChatPojo> list = chatService.getallchats();
        for(ChatPojo chartPojo:list){
           chartPojo.setCommentcolor("green");
           if(session.getAttribute("veri")!=null&&adminService.pikeupinformation((String)session.getAttribute("veri")).getOnoff()==1){
               if(session.getAttribute("veri").equals(chartPojo.getCriticaccount())){
                   chartPojo.setCommentcolor("red");
               }
           }
            chats.add(chartPojo);
        }
        model.addAttribute("chats",chats);
        return "chatroom";
    }

    @RequestMapping(value = "getchatrecods",produces = "text/html;charset=UTF-8" )
    @ResponseBody
    public String getchatrecods(String records,HttpSession session){
        if(session.getAttribute("veri")!=null&&adminService.pikeupinformation((String)session.getAttribute("veri")).getOnoff()==1){
            if(!records.trim().isEmpty()){
                String account=(String)session.getAttribute("veri");
                chatService.addrecords(new ChatPojo(0,account,adminService.pikeupinformation(account).getUsername(),records,times.getymdhms()));
                return adminService.pikeupinformation((String)session.getAttribute("veri")).getUsername();
            }
            return null;
        }else{
            return null;
        }
    }

    @ResponseBody
    @RequestMapping("getallrecords")
    public List<ChatPojo> getallrecords(HttpSession session){
        int currentid=chatService.getlastid();
        int oldid=(int)session.getAttribute("NumberOfChats");
        List<ChatPojo> list = new ArrayList<>();
        if(currentid>oldid){
            oldid=oldid+1;
            while(oldid<=currentid){
                ChatPojo getrecordsbyid = chatService.getrecordsbyid(oldid);
                if(getrecordsbyid.getCriticaccount().equals((String)session.getAttribute("veri"))){
                    getrecordsbyid.setCommentcolor("red");
                }else{
                    getrecordsbyid.setCommentcolor("green");
                }
                list.add(getrecordsbyid);
                oldid++;
            }
            session.setAttribute("NumberOfChats",chatService.getlastid());
            return list;
        }else{
            return null;
        }
    }
}
