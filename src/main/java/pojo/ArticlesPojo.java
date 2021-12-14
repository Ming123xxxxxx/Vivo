package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/8 18:04
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ArticlesPojo {
    private int id;
    private String name;
    private String author;
    private String authoraccount;
    private String title;
    private String local;
    private String times;
    private int up;
    private int low;
    private int download;
    private int collection;
    private int hot;

    public ArticlesPojo(int id, String name,String author,String authoraccount, String title, String local, String times) {
        this.id = id;
        this.name=name;
        this.author = author;
        this.authoraccount=authoraccount;
        this.title = title;
        this.local = local;
        this.times = times;
    }

}

