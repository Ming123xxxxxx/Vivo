package service;

import org.apache.ibatis.annotations.Param;
import pojo.ArticlesPojo;

import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/10 17:48
 */
public interface ArticlesService {
    int addtext(ArticlesPojo articlesPojo);
    List<ArticlesPojo> getalltext();
    ArticlesPojo getBook(String name);
    List<ArticlesPojo> getpersonalbooks(String account);
    int deletebook(String name);
    int getcount();
    List<ArticlesPojo> getnewbooks(int id);
    int getlastid();
}
