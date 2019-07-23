package util;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.Date;
import java.util.Calendar;

/**
 * @FileName Methodc
 * @Author CandyMuj
 * @Date 2019/5/27 14:06
 * @Version 1.0
 */
public class Methodc {

    public static ArrayList<String> array2list(String[] array) {
        ArrayList<String> list = new ArrayList<>();
        for (String s : array) {
            list.add(s);
        }
        return list;
    }

    /**
     * 根据排序字符串，返回排序sql
     *
     * @param orderbyList
     * @return
     */
    public static String getOrderbyStr(List<String> orderbyList) {
        String s = "";
        if (orderbyList != null && orderbyList.size() > 0) {
            s += " order by ";
            for (int i = 0; i < orderbyList.size(); i++) {
                if (i < orderbyList.size() - 1) {
                    s += orderbyList.get(i) + ",";
                } else {
                    s += orderbyList.get(i);
                }
            }
        }
        return s;
    }

    /**
     * 人民币转换：分转元
     *
     * @param cents
     * @return
     */
    // public static double cents2dollar(int cents) {
    // return Mathc.divide(cents, 100);
    // }

    /**
     * 人民币转换：元转分 直接取小数后两位即精确到分（不进行四舍五入）
     *
     * @param dollar
     * @return
     */
    public static int dollar2cents(double dollar) {
        return (int) Mathc.multipy(Mathc.noroundDouble(dollar), 100);
    }

    public static String InputStreamTOString(InputStream in) throws Exception {
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        byte[] data = new byte[4096];
        int count = -1;
        while ((count = in.read(data, 0, 4096)) != -1)
            outStream.write(data, 0, count);
        data = null;
        return new String(outStream.toByteArray(), "ISO-8859-1");
    }

    /**
     * 数组选择排序 升序
     *
     * @param num
     */
    public static void sortSelect(int[] num) {
        int temp = 0;
        for (int i = 0; i < num.length - 1; i++) {
            for (int j = i + 1; j < num.length; j++) {
                if (num[i] > num[j]) {
                    temp = num[i];
                    num[i] = num[j];
                    num[j] = temp;
                }
            }
        }
    }

    /**
     * 数组逆序
     *
     * @param num
     */
    public static void reverse(int[] num) {
        int temp = 0;
        for (int min = 0, max = num.length - 1; min < max; min++, max--) {
            temp = num[min];
            num[min] = num[max];
            num[max] = temp;
        }
    }

    public static Object[] listToArray(ArrayList<Object> list) {
        return list != null && list.size() != 0 ? list.toArray(new Object[list.size()]) : null;
    }

    public static String[] ListToArray(ArrayList<String> list) {
        return list != null && list.size() != 0 ? list.toArray(new String[list.size()]) : null;
    }

    /**
     * 校验国内手机号
     *
     * @param phone
     * @return
     */
    public static boolean checkPhone(String phone) {
        return Pattern.compile("0?(13|14|15|17|18|19)[0-9]{9}").matcher(phone).matches();
    }

    /**
     * date2 比 date1 多的天数
     *
     * @param date1
     * @param date2
     * @return
     */
    public static int differentDays(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);

        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        int day1 = cal1.get(Calendar.DAY_OF_YEAR);
        int day2 = cal2.get(Calendar.DAY_OF_YEAR);

        int year1 = cal1.get(Calendar.YEAR);
        int year2 = cal2.get(Calendar.YEAR);
        if (year1 != year2) {  // 同一年
            int timeDistance = 0;
            for (int i = year1; i < year2; i++) {
                if (i % 4 == 0 && i % 100 != 0 || i % 400 == 0) {  // 闰年
                    timeDistance += 366;
                } else {  // 不是闰年
                    timeDistance += 365;
                }
            }

            return timeDistance + (day2 - day1);
        } else {  // 不同年
            System.out.println("判断day2 - day1 : " + (day2 - day1));
            return day2 - day1;
        }
    }

    public static void main(String[] s) {
        // System.out.println(dollar2cents(23.6566));
        // System.out.println(Mathc.noroundDouble(23.6566));

        // int[] arr = new int[]{1, 3, 2, 8, 3};
        // sortSelect(arr);

        // System.out.println(checkPhone("13666665555"));

    }

}
