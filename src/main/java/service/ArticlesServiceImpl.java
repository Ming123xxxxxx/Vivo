package service;

import mapper.ArticlesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import pojo.ArticlesPojo;

import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/10 17:48
 */
public class ArticlesServiceImpl implements  ArticlesService{

    @Autowired
    ArticlesMapper articlesMapper;

    public void setArticlesMapper(ArticlesMapper articlesMapper){
        this.articlesMapper=articlesMapper;
    }

    @Override
    public int addtext(ArticlesPojo articlesPojo) {
        return articlesMapper.addtext(articlesPojo);
    }

    @Override
    public List<ArticlesPojo> getalltext() {
        return articlesMapper.getalltext();
    }

    @Override
    public ArticlesPojo getBook(String name) {
        return articlesMapper.getBook(name);
    }


}
