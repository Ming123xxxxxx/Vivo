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
            books.add(articlesService.getBook(str));
        }
        model.addAttribute("books",books);
        return "communitys";
    }



}
