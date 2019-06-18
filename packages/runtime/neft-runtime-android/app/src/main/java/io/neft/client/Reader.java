package io.neft.client;

public class Reader {
    private final boolean[] booleans;
    private final int[] integers;
    private final float[] floats;
    private final String[] strings;

    private int booleansIndex = 0;
    private int integersIndex = 0;
    private int floatsIndex = 0;
    private int stringsIndex = 0;

    Reader(boolean[] booleans, int[] integers, float[] floats, String[] strings) {
        this.booleans = booleans;
        this.integers = integers;
        this.floats = floats;
        this.strings = strings;
    }

    public boolean getBoolean() {
        return booleans[booleansIndex++];
    }

    public int getInteger() {
        return integers[integersIndex++];
    }

    public float getFloat() {
        return floats[floatsIndex++];
    }

    public String getString() {
        return strings[stringsIndex++];
    }
}