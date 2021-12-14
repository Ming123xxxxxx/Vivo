package service;

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
}
