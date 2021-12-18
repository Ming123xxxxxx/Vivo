package test;



import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 温黎明
 * @version 1.0
 * @date 2021/11/23 19:25
 */
public class pol {
    public static void main(String[] args) {
            System.out.print("请输入年份:");
            Scanner s = new Scanner(System.in);
            int a = s.nextInt();
            boolean tof;
            System.out.print("请输入月份:");
            Scanner s1 = new Scanner(System.in);
            int b = s.nextInt();
            int[] arr = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
            if (((a % 4 == 0) & (a % 100 != 0)) | (a % 400 == 0)) {
                tof = true;
                System.out.println("闰年");
                arr[2]++;
            } else {
                tof = false;
                System.out.println("平年");
            }
            System.out.println(arr[b]);


    }

    @Test
    public void getweek () throws Throwable{

        String pTime=2021+"-"+10+"-"+1;
        System.out.println(pTime instanceof String);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        Date tmpDate = format.parse(pTime);

        Calendar cal = Calendar.getInstance();

        String[] weekDays = { "7", "1", "2", "3", "4", "5", "6" };

        try {

            cal.setTime(tmpDate);

        } catch (Exception e) {

            e.printStackTrace();

        }

        int w = cal.get(Calendar.DAY_OF_WEEK) - 1; // 指示一个星期中的某天。

        if (w < 0)

            w = 0;

        System.out.println( weekDays[w]);

    }


    @Test
    public void ssss(){
        List list = new ArrayList();
        list.add(0,"10");
        list.add(1,"20");
        list.set(0,"30");
        System.out.println(list.toString());

    }
}
