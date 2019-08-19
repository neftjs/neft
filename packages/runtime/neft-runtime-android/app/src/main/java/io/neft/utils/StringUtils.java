package io.neft.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

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

    public static String getStringFromInputStream(InputStream stream) throws IOException {
        ByteArrayOutputStream byteStream = new ByteArrayOutputStream(stream.available());

        int count;
        byte[] buffer = new byte[1024];
        while ((count = stream.read(buffer)) > 0) {
            byteStream.write(buffer, 0, count);
        }

        return byteStream.toString();
    }
}
