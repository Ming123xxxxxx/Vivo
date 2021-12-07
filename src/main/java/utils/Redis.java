package utils;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import redis.clients.jedis.Jedis;
import service.AdminService;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;


/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/11/20 21:21
 */
public class Redis {

    @Autowired
    Times times;

    @Autowired
    @Qualifier("AdminServiceImpl")
    private AdminService adminService;

    private  Jedis jedis =jedis= new Jedis("192.168.118.135",6379);

    //删除对应账号的value
    //注销的同时删除此value
    //若为1,则表示成功
    //若为0,则表示失败
    public int delkey(String account){
        int p=0;
        try{
            p = Integer.parseInt(String.valueOf(jedis.zrem("User_Online_Status",account)));
            if(p==0){
                return p;
            }
            p = Integer.parseInt( String.valueOf(jedis.del(account)));
        }finally {
            jedis.close();
        }
        return p;
    }

    //设置用户在线
    //在线则给account添加对应的value
    public void setOnL(String account){
        try{
            //获取当前时间和注册时间间隔的天数
            String regdate = adminService.pikeupinformation(account).getRegdate();
            String getymd = times.getymd();
            int p=times.getTimeIntervel(regdate,getymd);

            jedis.zadd("User_Online_Status",1,account);
            if(Integer.parseInt(String.valueOf(jedis.ttl("User_Online_Status")))==-1){
                //设置"User_Online_Status"的过期时间
                jedis.expire("User_Online_Status",times.getTime());
            }

            jedis.zadd("Onpepo",1,account);

            System.out.println("过期时间:"+jedis.ttl("User_Online_Status"));
            //获取当前日期的访问人数
            if( jedis.exists(times.gety()+":"+times.getm()+":"+times.getd())){
                if(!jedis.getbit(account,p)){
                    jedis.incr(times.gety()+":"+times.getm()+":"+times.getd());
                }
            }else{
                jedis.set(times.gety()+":"+times.getm()+":"+times.getd(),"1");
            }

            //给每个用户添加一个list,第一个参数为用户账户,第二个参数为（当前时间-注册时间-1）,第三个参数为当天是否在线
            jedis.setbit(account,p,"1");
        } catch (ParseException e) {
            e.printStackTrace();
        } finally {
            jedis.close();
        }
    }

    //设置用户离线
    //离线则给对应的value-1=0
    public void setOffL(String account){
        try{
            jedis.zincrby("Onpepo",-1,account);
        }finally {
            jedis.close();
        }
    }

    //获取用户次月的签到情况
    //参数: 账号  当前日历时期与注册时候间隔天数， 此月当前日历年份，此月当前日历月份，此月当前日历有几天，当前月1号为星期几
    //-2代表这个月一号前面的日期，知道星期一为止
    //-1代表未注册和未来时间
    //0代表未签到
    //1代表已签到
    public List getMonthsArrendance(String account,int offset,int years,int months,int days,int week){
        int p=1;
        int l=1;
        List list = new ArrayList();
        //若日历当前年份/月份小于系统当前年份/月份
        while(l<week){
            list.add(-2);
            l++;
        }
        if(years<times.gety()||(years==times.gety()&&months<times.getm())){
            for (;p<=days;p++){
                if(offset+p<0){
                        list.add(-1);
                }else{
                    if(jedis.getbit(account,offset+p)){
                        list.add(1);
                    }else{
                        list.add(0);
                    }
                }
            }
        }else if(years==times.gety()&&months==times.getm()){

            for (p=1;p<=days;p++){

                try{
                   if(jedis.getbit(account,offset+p)){
                       list.add(1);
                   }else {
                       if(p>times.getd()){
                           list.add(-1);
                       }else {
                           list.add(0);
                       }
                   }
                }catch (Exception e){
                       list.add(-1);
                }

            }

        }else if(years>times.gety()||(years==times.gety()&&months>times.getm())){

            for (;p<=days;p++){

                    list.add(-1);

            }
        }

        return list;
    }

    //返回当前在线人数
    //若出问题则返回-1
    public int OUser(){
        int user_online=-1;
        try{
            user_online = Integer.parseInt(String.valueOf(jedis.zcount("Onpepo", 1, 1)));
        }finally {
            jedis.close();
        }
        return user_online;
    }

    //返回某个日期在线人数
    //若不存在返回-1
    public int OnSize(int years,int months,int days){
        if(jedis.exists( jedis.get(years + ":" + months + ":" + days))){
            int s =Integer.parseInt( jedis.get(years + ":" + months + ":" + days));
            return s;
        }else{
            return -1;
        }
    }

    //返回当天访问人数
    //若出问题则返回-1
    public int currentperson(){
        int user_online=-1;
        try{
            user_online = Integer.parseInt(String.valueOf(jedis.zcount("User_Online_Status", 0, 1)));
        }finally {
            jedis.close();
        }
        return user_online;
    }

}
