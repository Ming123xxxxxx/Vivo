package utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/12/9 11:44
 */
public class OperationText {

    //创建文件并写入文本
    //返回值为List
    //get(0):文件名,不带后缀
    //get(1):文件的绝对路径
    public List writetext(String writes){
        File file =null;
        BufferedWriter bufferedWriter=null;
        String sp = null;
        List list=new ArrayList();
        String str="D:\\IntelliJ IDEA 2020.1\\Vivo\\texts\\";
        String st=String.valueOf(UUID.randomUUID()).replaceAll("-","");
        String afters=".txt";
        try {
            sp=str+st+afters;
            file = new File(sp);
            while (file.exists()){
               st=String.valueOf(UUID.randomUUID()).replaceAll("-","");
               sp=str+st+afters;
               file = new File(sp);
            }
            bufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(sp),"UTF-8"));
            bufferedWriter.write(writes);
            list.add(0,st);
            list.add(1,String.valueOf(file.getAbsoluteFile()));
        }catch (Exception e){
            if(new File(sp).exists()){
                new File((sp)).delete();
            }
        } finally {
            if(bufferedWriter!=null){
                try {
                    bufferedWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }
}
