package io.neft.utils;

public class StringUtils {
    public static boolean equals(String val1, String val2) {
        if (val1 == val2) {
            return true;
        }
        if (val1 == null || val2 == null) {
            return false;
        }
        return val1.equals(val2);
    }

    public static String capitalize(String str) {
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }
}
