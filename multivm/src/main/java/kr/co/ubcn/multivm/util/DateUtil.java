package kr.co.ubcn.multivm.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static String getCurrentDateTime(){
        Date date =new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(date);
    }
    public static String getCurrentDateTime2(){
        Date date =new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
        return sdf.format(date);
    }
    public static String getCurrentDate(){
        Date date =new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
    public static String getCurrentYYMM(){
        Date date =new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyMM");
        return sdf.format(date);
    }
    public static String getCurrentYYYYMM(){
        Date date =new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMM");
        return sdf.format(date);
    }
    public static String getCurrentYYYYMMDD(){
        Date date =new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
        return sdf.format(date);
    }
    public static String getCurrentHHMMSS(){
        Date date =new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("HHmmss");
        return sdf.format(date);
    }
}
