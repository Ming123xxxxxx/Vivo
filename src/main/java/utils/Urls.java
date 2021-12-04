package utils;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/4 13:14
 */
public class Urls {

    private String uls="http://192.168.1.156:8080/Vivo_war_exploded";

    public String index(){
        return uls;
    }

    public String register(){
        return uls+"/registerinfo/register.action";
    }

    public String acenter(){
        return uls+"/atcenter/pinformation.action";
    }

    public String admin(){
        return uls+ "/admin/jump";
    }

}
