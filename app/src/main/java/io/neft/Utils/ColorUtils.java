package io.neft.Utils;

public class ColorUtils {
    public static int RGBAtoARGB(int val) {
        return ((val & 0xFFFFFF00) >> 8) |  // __RRGGBB
                ((val & 0x000000FF) << 24); // AA______
    }

    public static int setAlpha(int argb, int alpha) {
        return ((argb & 0x00FFFFFF) |  // __RRGGBB
                (alpha & 0xFF) << 24); // AA______
    }

    public static int byAlpha(int argb, int alpha) {
        float left = (255 - argb & 0xFF) / 255f;
        float right = (255 - alpha & 0xFF) / 255f;
        return setAlpha(argb, (int) (255 - left * right * 255));
    }
}
