package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import pojo.ArticlesPojo;
import service.ArticlesService;
import utils.OperationText;
import utils.RedisArtices;

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
    OperationText operationText;

    @Autowired
    RedisArtices redisArtices;

    @Autowired
    @Qualifier("ArticlesServiceImpl")
    private ArticlesService articlesService;


    @RequestMapping("into")
    public String into(Model model){

        List<String> list =redisArtices.allbooks(1,7);
        List<ArticlesPojo> books = new ArrayList<>();
        for(String str:list){
            ArticlesPojo book = articlesService.getBook(str);
            List list1 =redisArtices.count(str);
            book.setUp((new Double((Double) list1.get(0)).intValue()));
            book.setLow((new Double((Double) list1.get(1)).intValue()));
            book.setDownload(new Double((Double) list1.get(2)).intValue());
            book.setCollection(new Double((Double) list1.get(3)).intValue());
            book.setHot((Double) list1.get(4));
            books.add(book);
        }
        model.addAttribute("books",books);
        return "communitys";
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
