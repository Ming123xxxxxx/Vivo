package mapper;

import org.apache.ibatis.annotations.Param;
import pojo.ArticlesPojo;

import java.util.List;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/10 17:40
 */
public interface ArticlesMapper {
    int addtext(ArticlesPojo articlesPojo);
    List<ArticlesPojo> getalltext();
    ArticlesPojo getBook(@Param("name") String name);
    List<ArticlesPojo> getpersonalbooks(@Param("authoraccount") String account);
    int deletebook(@Param("name")String name);
    int getcount();
    List<ArticlesPojo> getnewbooks(@Param("id") int id);
    int getlastid();
}
