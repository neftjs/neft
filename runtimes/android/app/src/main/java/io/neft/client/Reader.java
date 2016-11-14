package io.neft.client;

public class Reader {
    public boolean[] booleans;
    public int[] integers;
    public float[] floats;
    public String[] strings;

    public int booleansIndex = 0;
    public int integersIndex = 0;
    public int floatsIndex = 0;
    public int stringsIndex = 0;


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