package test;

import org.junit.Test;
import redis.clients.jedis.Jedis;
import utils.MD5Util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Scanner;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/11/20 21:00
 */

//测试代码
//测试代码
//测试代码
//测试代码
public class Te {

    public static void main(String[] args) {
        Jedis jedis = new Jedis("192.168.118.135",6379);

        //添加成功返回1
        //失败返回0
//        Long sadd = jedis.sadd("user", "lucy");
//
//        System.out.println(  jedis.srandmember("user"));
//        System.out.println(  jedis.del("user"));
        jedis.zadd("uo",1,"413");
        jedis.zadd("uo",1,"7123");
        jedis.zadd("uo",1,"23512");
        jedis.zadd("uo",1,"5121");
        jedis.zadd("uo",0,"gr413");
        jedis.zadd("uo",0,"wda413");

        Long uo = jedis.zcount("uo", 1, 1);
        Long uo1 = jedis.zcount("uo", 0, 0);
        System.out.println("Uo="+uo);
        System.out.println("Uo1="+uo1);
        int p=Integer.parseInt(String.valueOf(jedis.ttl("uo")));
        System.out.println("uo2是否过期:"+p);
        jedis.del("uo");
        System.out.println("uo2是否过期:"+jedis.ttl("uo"));

        jedis.set("po","0");
        jedis.incrBy("po",10);
        int po =Integer.parseInt(jedis.get("po"));
        System.out.println(po);
    }


    @Test
    public void getlist(){
        Jedis jedis = new Jedis("192.168.118.135",6379);
        jedis.rpush("uo","2","0");
        List<String> uo = jedis.lrange("uo", 0, -1);
        int uo1 = Integer.parseInt(jedis.lpop("uo"));
        if (uo1==2){
            System.out.println("true");
        }else{
            System.out.println("false");
        }

        for(String list:jedis.lrange("uo",0,-1)){
            System.out.println("uo:"+list);
        }
//        System.out.println(jedis.lrange("uo",1,2));
    }

    @Test
    public void getTime(){
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, 1);
        // 改成这样就好了
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.MILLISECOND, 0);
        System.out.println(Integer.parseInt(String.valueOf((cal.getTimeInMillis() - System.currentTimeMillis()) / 1000)));
    }


    @Test
    public void ti(){
        Date date=new Date();
        DateFormat format=new SimpleDateFormat("yyyyMMdd");
//        System.out.println(format.format(date));
//        //DateFormat类的静态工厂方法
//        System.out.println(format.getInstance().format(date));
//        System.out.println(format.getDateInstance().format(date));
//        System.out.println(format.getTimeInstance().format(date));
        System.out.println(format.getDateTimeInstance().format(date));

        //DateFormat带参数的静态工厂方法
        //第一个参数是静态变量style有4中取值0、1、2、3分别对应SHORT、MIDIUM、LONG、FULL
//        //第二个参数根据环境敏感的Locale类的静态变量自定义输出
//        System.out.println(format.getDateInstance(0, Locale.CHINA).format(date));
//        System.out.println(format.getTimeInstance(0,Locale.CHINA).format(date));
//
//        System.out.println(format.getDateTimeInstance(2,2).format(date));
    }

    @Test
    public void getZset(){
        Jedis jedis = new Jedis("192.168.118.135", 6379);
        jedis.setbit("uo", 0, "1");
        jedis.setbit("uo", 3, "1");
        jedis.setbit("uo", 6, "1");
        jedis.setbit("uo", 8, "1");
        jedis.setbit("uo", 9, "1");
        jedis.setbit("uo", 10, "1");

        int i=1;

        while(i<10){
            try{
                Long uo = jedis.bitcount("uo");
                System.out.println("总共登录天数:" + uo);
                int sum = 0;
                if(jedis.getbit("uo", -1)){
                    System.out.println("wwwwwww");
                }else{
                    System.out.println("qqqqqqq");
                }

                System.out.println("jedis1=" + jedis.getbit("uo", -1));
                System.out.println("xxxxx");
                System.out.println("jedis2=" + jedis.getbit("uo", -1));
            }catch(Exception e){
                System.out.println("jedis3=" + jedis.getbit("uo", 1));
            } finally{
                i++;
                jedis.del("uo");
            }

        }


    }

    @Test
    public void gett(){
        Calendar cal=Calendar.getInstance(); //调用Calendar 中的方法；
        cal.set(Calendar.DAY_OF_MONTH, 1); // 把时间调整为当月的第一天；
        cal.add(Calendar.MONTH,1); // 月份调至下个月；
        cal.add(Calendar.DAY_OF_MONTH, -1); // 时间减去一天（就等于上个月的最后一天）
        int month=cal.get(Calendar.MONTH)+1; //调取月份（月份在表示中会少 1，如：1月份得出数字是 0；
        int days=cal.get(Calendar.DAY_OF_MONTH);//调取当月的天数。
        System.out.println(month+"月份有"+days+"天");//打印最后被结果。

    }

     @Test
    public void x() throws ParseException {
         SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
         Date date1 = simpleDateFormat.parse("2020-05-01");
         Date date2 = simpleDateFormat.parse("2020-05-01");
         int days = (int) ((date2.getTime() - date1.getTime()) / (1000*3600*24));
         System.out.println(days);
     }

     @Test
    public void xxx() throws ParseException {
         Calendar now = Calendar.getInstance();
         System.out.println("年: " + now.get(Calendar.YEAR));
         System.out.println("月: " + (now.get(Calendar.MONTH) + 1) );
         System.out.println("日: " + now.get(Calendar.DAY_OF_MONTH));
     }

     @Test
    public void xx(int p){
         System.out.println("p="+p);
     }

}
