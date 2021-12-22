package utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/11/21 19:16
 */
public class Times {

    //获取系统时间离今天0:00的间隔秒数
    public int getTime(){
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, 1);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return Integer.parseInt(String.valueOf((cal.getTimeInMillis() - System.currentTimeMillis()) / 1000));
    }

    //获取当前时间的年月日 格式如:2020-12-12
    public String getymd() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(date);
    }

    public int gety(){
        Calendar now = Calendar.getInstance();
        return now.get(Calendar.YEAR);
    }

    public int getm(){
        Calendar now = Calendar.getInstance();
        return  (now.get(Calendar.MONTH) + 1);
    }

    public int getd(){
        Calendar now = Calendar.getInstance();
        return  now.get(Calendar.DAY_OF_MONTH);
    }

    //获取当前时间的年月日时分秒，格式如:2021年11月23日 下午5:39:41
    public String getymdhms() {
        Date date = new Date();
        SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return formate.getDateTimeInstance().format(date);
    }

    //获取当前时间和注册时间的间隔天数
    public  int getTimeIntervel(String regdate,String currenttime ) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = simpleDateFormat.parse(regdate);
        Date date2 = simpleDateFormat.parse( currenttime);
        int days = (int) ((date2.getTime() - date1.getTime()) / (1000*3600*24));
        return days;
    }

    //获取某年某月的天数
    //成功则返回天数,失败则返回-1
    public int getNumberDays(int years,int months){
        if(months>12||months<1){
            return -1;
        }else{
            boolean tof;
            int[] arr = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
            if (((years % 4 == 0) & (years % 100 != 0)) | (years % 400 == 0)) {
                tof = true;
                arr[2]++;
            } else {
                tof = false;
            }
            return arr[months];
        }
    }

    //返回某个月的1号为星期几
    public int getMonthesWeek(int years,int months){
        if(months>12||months<1){
            return -1;
        }else{
            String pTime=years+"-"+months+"-"+"1";
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            try{
                Date tmpDate = format.parse(pTime);

                Calendar cal = Calendar.getInstance();

                String[] weekDays = { "7", "1", "2", "3", "4", "5", "6" };

                try {

                    cal.setTime(tmpDate);

                } catch (Exception e) {

                    e.printStackTrace();

                }

                int w = cal.get(Calendar.DAY_OF_WEEK) - 1; // 指示一个星期中的某天。

                if (w < 0) {
                    w = 0;
                }
                return Integer.parseInt(weekDays[w]);
            } catch (ParseException e) {
                e.printStackTrace();
                return -1;
            }
        }

    }

}
