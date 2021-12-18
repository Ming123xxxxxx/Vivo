package utils;

import redis.clients.jedis.Jedis;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/8 17:49
 */
public class RedisArtices {

    private Jedis jedis =jedis= new Jedis("192.168.118.135",6379);

    //按照热度排
    public List<String> allbooks(int start,int end){
        List<String> list = new ArrayList();

        try{
            Set<String> up = jedis.zrevrange("hot",start-1,end);
            for(String books:up){
                list.add(books);
            }
        }finally {
            jedis.close();
        }
        return list;
    }

    public void addtext(String textname){
       try{
           //点赞数
           jedis.zadd("up",0,textname);
           //点踩数
           jedis.zadd("low",0,textname);
           //下载数
           jedis.zadd("download",0,textname);
           //收藏数
           jedis.zadd("collections",0,textname);
           //热度
           jedis.zadd("hot",0,textname);
       }finally {
           jedis.close();
       }
    }

    public List count(String name){
        List list = new ArrayList();

        try{
            list.add(0,jedis.zscore("up",name));
            list.add(1,jedis.zscore("low",name));
            list.add(2,jedis.zscore("download",name));
            list.add(3,jedis.zscore("collections",name));
            list.add(4,jedis.zscore("hot",name));
        }finally {
            jedis.close();
        }
        return list;
    }

    //获取getusercommunityinfo中account的value
    public int getusercommunityinfo(String account,String textname,int incry){
        
        if(jedis.zscore("account:community",account+textname)==null){
            jedis.zadd("account:community",0,account+textname);
        }
            //判断是否点击的是收藏，并且收藏中有无该文件，
        if(!(incry==4&&jedis.sismember(account+"collections",textname))){
            //增加文本到收藏中
            jedis.sadd(account+"collections",textname);
        }

        return jedis.zscore("account:community",account+textname).intValue();

    }

    //获取用户收藏的文章
    public List getcollections(String account){
        List<String> list = new ArrayList<>();

        try {
            Set<String> smembers = jedis.smembers(account + "collections");
            for(String books:smembers){
                list.add(books);
            }
        }finally {
            jedis.close();
        }
        return list;
    }

    //删除收藏列表书名
    public void deletecollections(String account,String textname){
        try {
            jedis.srem(account+"collections",textname);
            jedis.zincrby("account:community", -4,account+textname);
            jedis.zincrby("collections", -1, textname);
            jedis.zincrby("hot", -4, textname);
        }finally {
            jedis.close();
        }
    }

    //热度-点赞-点踩-收藏
    public void opration(String textname, String account, String type){

        int incry=0;
        if(type.equals("up")){
            incry=1;
        }else if(type.equals("low")){
            incry=2;
        }else if(type.equals("collections")){
            incry=4;
        }
       int p=getusercommunityinfo(account,textname,incry);
       try {

           if(p==0) {
                if(incry == 1){
                    jedis.zincrby("account:community", 1, account+textname);
                    jedis.zincrby("up", 1, textname);
                    jedis.zincrby("hot", 10, textname);
                }
                 if (incry == 2) {
                     jedis.zincrby("account:community", 2, account+textname);
                     jedis.zincrby("low", 1, textname);
                     jedis.zincrby("hot", -10, textname);
                 }
                 if (incry == 4) {
                     jedis.zincrby("account:community", 4, account+textname);
                     jedis.zincrby("collections", 1, textname);
                     jedis.zincrby("hot", 4, textname);
                 }
           }else if(p==1) {
                if(incry == 1){
                    jedis.zincrby("account:community", -1, account+textname);
                    jedis.zincrby("up", -1, textname);
                    jedis.zincrby("hot", -10, textname);
                }
                if (incry == 2) {
                    jedis.zincrby("account:community", 1, account+textname);
                    jedis.zincrby("up", -1, textname);
                    jedis.zincrby("low", 1, textname);
                    jedis.zincrby("hot", -20, textname);
                }
                if (incry == 4) {
                    jedis.zincrby("account:community", 4, account+textname);
                    jedis.zincrby("collections", 1, textname);
                    jedis.zincrby("hot", 4, textname);
                }

            }else if(p==2) {
                if (incry == 1) {
                    jedis.zincrby("account:community", -1, account+textname);
                    jedis.zincrby("up", 1, textname);
                    jedis.zincrby("low", -1, textname);
                    jedis.zincrby("hot", 20, textname);
                }
                if (incry == 2) {
                    jedis.zincrby("account:community", -2, account+textname);
                    jedis.zincrby("low", -1, textname);
                    jedis.zincrby("hot", 10, textname);
                }
                if (incry == 4) {
                    jedis.zincrby("account:community", 4, account+textname);
                    jedis.zincrby("hot", 4, textname);
                    jedis.zincrby("collections",1 , textname);
                }
            }else if(p==4) {
                if (incry == 1) {
                    jedis.zincrby("account:community", 1, account+textname);
                    jedis.zincrby("up", 1, textname);
                    jedis.zincrby("hot", 10, textname);
                }
                if (incry == 2) {
                    jedis.zincrby("account:community", 2, account+textname);
                    jedis.zincrby("up", -1, textname);
                    jedis.zincrby("hot", -10, textname);
                }
                if (incry == 4) {
                    jedis.zincrby("account:community", -4, account+textname);
                    jedis.zincrby("collections", -1, textname);
                    jedis.srem(account+"collections",textname);
                    jedis.zincrby("hot", -4, textname);
                }
            }else if(p==5){
                    if(incry == 1){
                        jedis.zincrby("account:community", -1, account+textname);
                        jedis.zincrby("up", -1, textname);
                        jedis.zincrby("hot", -10, textname);
                    }
                   if(incry==2){
                       jedis.zincrby("account:community",1,account+textname);
                       jedis.zincrby("up",-1,textname);
                       jedis.zincrby("hot",-20,textname);
                   }
                    if (incry == 4) {
                        jedis.zincrby("account:community", -4, account+textname);
                        jedis.srem(account+"collections",textname);
                        jedis.zincrby("collections", -1, textname);
                        jedis.zincrby("hot", -4, textname);
                    }
            }else if(p==6) {
                    if (incry == 1) {
                        jedis.zincrby("account:community", -1, account+textname);
                        jedis.zincrby("up", 1, textname);
                        jedis.zincrby("hot", 20, textname);
                    }
                    if(incry == 2){
                        jedis.zincrby("account:community",-2,account+textname);
                        jedis.zincrby("low",-1,textname);
                        jedis.zincrby("hot",10,textname);
                    }
                    if (incry == 4) {
                        jedis.zincrby("account:community", -4, account+textname);
                        jedis.srem(account+"collections",textname);
                        jedis.zincrby("collections", -1, textname);
                        jedis.zincrby("hot", -4, textname);
                    }
            }
       }finally {
           jedis.close();
       }

    }

    //删除
    public void deletebooks(String account,String bookname){

        try {
            //点赞数
            jedis.zrem("up",bookname);
            //点踩数
            jedis.zrem("low",bookname);
            //下载数
            jedis.zrem("download",bookname);
            //收藏数
            jedis.zrem("collections",bookname);
            //热度
            jedis.zrem("hot",bookname);

            Set<String> zrange = jedis.zrange("account:community", 0, -1);
            for(String zra:zrange){
                if(zra.contains(bookname)){
                    jedis.zrem("account:community",zra);
                }
            }
        }finally {
            jedis.close();
        }

    }

    //下载
    public void download(String textname){

        try{
            jedis.zincrby("download",1,textname);
            jedis.zincrby("hot",1,textname);
        }finally {
            jedis.close();
        }
    }

    //获取是否点赞-点踩-收藏
    public List upandlowandcollection(String account,String bookname){

        List<String> list = new ArrayList();

        list.add(0,"black");
        list.add(1,"black");
        list.add(2,"black");

        try {

            if(jedis.zscore("account:community", account + bookname)==null){
                return list;
            }

            int zscore = jedis.zscore("account:community", account + bookname).intValue();

            if(zscore==1||zscore==2){
                list.set(zscore-1,"red");
            }else  if(zscore==4){
                list.set(2,"red");
            }else if(zscore==5){
                list.set(0,"red");
                list.set(2,"red");
            }else if(zscore==6){
                list.set(1,"red");
                list.set(2,"red");
            }

        }finally {
            jedis.close();
        }

        return list;

    }

}
