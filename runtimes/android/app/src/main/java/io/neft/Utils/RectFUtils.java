package io.neft.Utils;

public class RectFUtils {
    public static boolean equals(android.graphics.RectF a, android.graphics.RectF b) {
        if (a == b) return true;
        if (a == null || b == null) return false;
        return a.left == b.left && a.top == b.top && a.right == b.right && a.bottom == b.bottom;
    }
}
