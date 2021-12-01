package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/1 18:51
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class AdminInfo {
    private int id;
    private String account;
    private String password;
}
