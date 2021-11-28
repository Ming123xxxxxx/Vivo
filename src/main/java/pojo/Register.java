package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/10/30 21:13
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Register {
    private String username;
    private String account;
    private String pwd;
    private String regdate;
    private String modifytime;
    private String lastlogintime;
}
