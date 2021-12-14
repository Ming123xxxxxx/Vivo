package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import pojo.ArticlesPojo;
import service.AdminService;
import service.ArticlesService;
import utils.OperationText;
import utils.RedisArtices;
import utils.Times;
import utils.Urls;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/8 16:59
 */
@Controller
@RequestMapping("artice")
public class Article {

    @Autowired
    Urls urls;

    @Autowired
    Times times;

    @Autowired
    @Qualifier("AdminServiceImpl")
    private AdminService adminService;

    @Autowired
    OperationText operationText;

    @Autowired
    RedisArtices redisArtices;

    @Autowired
    @Qualifier("ArticlesServiceImpl")
    private ArticlesService articlesService;

    @RequestMapping("into")
    public String into(HttpSession session){
        if(session.getAttribute("veri")==null){
            return "redirect:/log/on";
        }else{
            if(adminService.pikeupinformation((String)session.getAttribute("veri")).getOnoff()==1){
                return "artices";
            }else{
                return "redirect:/log/on";
            }
        }
    }

    @RequestMapping("select")
    @ResponseBody
    public String select(String vl){
        if(Integer.parseInt(vl)==1){
            return urls.toartices();
        }else {
            return "0";
        }
    }

    @RequestMapping("writetext")
    public String writetext(String titl,String filetxt,HttpSession session){

            if((!titl.trim().isEmpty())&&(!filetxt.trim().isEmpty())){
                List writetext = operationText.writetext(filetxt);
                String account=(String)session.getAttribute("veri");

                ArticlesPojo articlesPojo =new ArticlesPojo(0,(String)writetext.get(0),adminService.pikeupinformation(account).getUsername(),account,titl,(String)writetext.get(1),times.getymd());
                //将此文件记录到数据库
                articlesService.addtext(articlesPojo);
                //将此文件添加到redis中
                redisArtices.addtext((String)writetext.get(0));
                return "redirect:/community/into";
            }else{
                System.out.println("xxxx");
                return "artices";
            }
    }

    @RequestMapping("upload")
    public String  readetext(@RequestParam(value="files",required=true)MultipartFile multipartFile, String titls, HttpSession session) throws IOException {
             if(!multipartFile.isEmpty()&&titls!=null){
                 //获取上传文件的文件名
                 String filename=multipartFile.getOriginalFilename();
                 //获取上传文件的文件的后缀名
                 String suffixName=filename.substring(filename.lastIndexOf("."));
                 if(suffixName.equals(".txt")) {
                     //随机生成一个字符串且将字符串中的“-”替换成空字符串并赋值给UUID,并将UUID作为文件名
                     String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                     String locals="D:\\IntelliJ IDEA 2020.1\\Vivo\\texts\\";
                     filename = locals+uuid + suffixName;
                     File file = new File(filename);
                     //判断文件是否存在
                     while(file.exists()) {
                         uuid = UUID.randomUUID().toString().replaceAll("-", "");
                         filename = locals+uuid + suffixName;
                     }
                     multipartFile.transferTo(file);

                     String account=(String)session.getAttribute("veri");

                     ArticlesPojo articlesPojo =new ArticlesPojo(0,uuid,adminService.pikeupinformation(account).getUsername(),account,titls,filename,times.getymd());
                     //将此文件记录到数据库
                     articlesService.addtext(articlesPojo);
                     //将此文件添加到redis中
                     redisArtices.addtext(uuid);
                     return "redirect:/community/into";
                 }else{
                     return "artices";
                 }
             }else{
                 return "artices";
             }
    }
}
