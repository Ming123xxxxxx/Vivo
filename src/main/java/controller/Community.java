package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.ArticlesPojo;
import service.AdminService;
import service.ArticlesService;
import utils.OperationText;
import utils.RedisArtices;

import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/8 15:25
 */
@Controller
@RequestMapping("community")
public class Community {

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
    public String into(Model model,HttpSession session){

        List<String> list =redisArtices.allbooks(1,10);
        List<ArticlesPojo> books = new ArrayList<>();
        for(String str:list){
            ArticlesPojo book = articlesService.getBook(str);
            List list1 =redisArtices.count(str);
            book.setUp((new Double((Double) list1.get(0)).intValue()));
            book.setLow((new Double((Double) list1.get(1)).intValue()));
            book.setDownload(new Double((Double) list1.get(2)).intValue());
            book.setCollection(new Double((Double) list1.get(3)).intValue());
            book.setHot((Double) list1.get(4));
            List list2 = redisArtices.upandlowandcollection((String)session.getAttribute("veri"),str);
            book.setUpcolor((String)list2.get(0));
            book.setLowcolor((String)list2.get(1));
            book.setCollectioncolor((String)list2.get(2));
            books.add(book);
        }
        model.addAttribute("books",books);
        return "communitys";
    }

    @RequestMapping("operations")
    public String operations(String name, HttpSession session, String type){
        if(session.getAttribute("veri")!=null&&adminService.pikeupinformation((String)session.getAttribute("veri")).getOnoff()==1){
            redisArtices.opration(name,(String)session.getAttribute("veri"),type);
            return "redirect:/community/into";
        }else{
            return "redirect:/log/on";
        }

    }

    @ResponseBody
    @RequestMapping("publishbook")
    public List<ArticlesPojo> publishbook(HttpSession session){

        List<ArticlesPojo> veri = articlesService.getpersonalbooks((String) session.getAttribute("veri"));
        List<ArticlesPojo> books = new ArrayList<>();
        for(ArticlesPojo apojo:veri){
            ArticlesPojo articlesPojo = apojo;
            List list1 =redisArtices.count(apojo.getName());
            articlesPojo.setUp((new Double((Double) list1.get(0)).intValue()));
            articlesPojo.setLow((new Double((Double) list1.get(1)).intValue()));
            articlesPojo.setDownload(new Double((Double) list1.get(2)).intValue());
            articlesPojo.setCollection(new Double((Double) list1.get(3)).intValue());
            articlesPojo.setHot((Double) list1.get(4));
            books.add(articlesPojo);
        }
        return books;
    }

    @ResponseBody
    @RequestMapping("collectionbooks")
    public List<ArticlesPojo> collectionbooks(HttpSession session){
        List<String> veri = redisArtices.getcollections((String) session.getAttribute("veri"));
        List list = new ArrayList();
        for(String str:veri){
            System.out.println("articlesService.getBook(str="+articlesService.getBook(str));
            if(articlesService.getBook(str)!=null){
                ArticlesPojo book = articlesService.getBook(str);
                List list1 =redisArtices.count(str);
                book.setUp(((Double)list1.get(0)).intValue());
                book.setLow((((Double)list1.get(1)).intValue()));
                book.setDownload(((Double)list1.get(2)).intValue());
                book.setCollection(((Double)list1.get(3)).intValue());
                book.setHot((Double) list1.get(4));
                list.add(book);
            }else{
                redisArtices.deletecollections((String) session.getAttribute("veri"),str);
                continue;
            }
        }
        return list;
    }

    @RequestMapping("deletebooks")
    public String deletebooks(HttpSession session,String textname){
        //删除文件
        new File(articlesService.getBook(textname).getLocal()).delete();
        //删除数据库文件时数据
        articlesService.deletebook(textname);
        //删除redis中文件数据
        redisArtices.deletebooks((String) session.getAttribute("veri"),textname);
        return "redirect:/community/into";
    }

    @RequestMapping("cancelcollection")
    public String cancelcollection(HttpSession session,String textname){
        redisArtices.deletecollections((String) session.getAttribute("veri"),textname);
        return "redirect:/community/into";
    }

    @RequestMapping("readtext")
    public String readtext(String name,Model model){
                BufferedReader bufferedReader=null;
                String text=null;
           try{
               String str="D:\\IntelliJ IDEA 2020.1\\Vivo\\texts\\";
               String downloadtext=str+name+".txt";
               bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(new File(downloadtext)),"UTF-8"));
               //创建字节数组
               //available():获取数据流里可读字节的总数
               char[] chars=new char[1024];
               int len;
               while((len=bufferedReader.read(chars))!=-1){
                   String sr=new String(chars,0,len);
                   text=text+sr;
               }
               text=text.replaceAll("null","");
           } catch (UnsupportedEncodingException e) {
               e.printStackTrace();
           } catch (FileNotFoundException e) {
               e.printStackTrace();
           } catch (IOException e) {
               e.printStackTrace();
           }finally {
               if(bufferedReader!=null){
                   try {
                       bufferedReader.close();
                   } catch (IOException e) {
                       e.printStackTrace();
                   }
               }
           }
          model.addAttribute("text",text);
          return "readbooks";
    }

}
