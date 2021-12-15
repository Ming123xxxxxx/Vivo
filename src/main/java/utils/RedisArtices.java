package utils;

import redis.clients.jedis.Jedis;

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

    public List<String> allbooks(int start,int end){
        List<String> list = new ArrayList();
        Set<String> up = jedis.zrange("up",start-1,end);
        for(String books:up){
            list.add(books);
        }
        return list;
    }

    public void addtext(String textname){
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
    }

    public List count(String name){
        List list = new ArrayList();
        list.add(jedis.zscore("up",name));
        list.add(jedis.zscore("low",name));
        list.add(jedis.zscore("download",name));
        list.add(jedis.zscore("collections",name));
        list.add(jedis.zscore("hot",name));
        return list;
    }

    //点赞
    public void up(String textname){
        jedis.zincrby("up",1,textname);
        jedis.zincrby("hot",1,textname);
    }

    //点踩
    public void low(String textname){
        jedis.zincrby("low",1,textname);
        jedis.zincrby("hot",-1,textname);
    }

    //下载
    public void download(String textname){
        jedis.zincrby("download",1,textname);
        jedis.zincrby("hot",1,textname);
    }

    //收藏
    public void collection(String textname){
        jedis.zincrby("collections",1,textname);
        jedis.zincrby("hot",1,textname);
    }



}
