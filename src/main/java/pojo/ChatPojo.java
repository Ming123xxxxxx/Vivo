package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/21 16:09
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ChatPojo {

    private int id;
    private String criticaccount;//评论的人的账号
    private String criticname;//评论人的名字
    private String comment;//评论内容
    private String times;//
    private String commentcolor;//评论颜色,自己为红色，其他人为蓝色

    public ChatPojo(int id, String criticaccount,String criticname, String comment, String times){
        this.id=id;
        this.criticaccount=criticaccount;
        this.criticname=criticname;
        this.comment=comment;
        this.times=times;
    }

}
