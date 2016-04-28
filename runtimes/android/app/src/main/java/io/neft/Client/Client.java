package io.neft.Client;

import android.util.Log;

import java.util.HashMap;

import io.neft.Native;

public class Client {
    private static final int OUT_ARRAYS_VALUE = 64;
    private static final int OUT_ARRAYS_INCREASE_VALUE = 24;

    static int EVENT_NULL_TYPE = 0;
    static int EVENT_BOOLEAN_TYPE = 1;
    static int EVENT_FLOAT_TYPE = 2;
    static int EVENT_STRING_TYPE = 3;

    final private InAction[] InActionValues = InAction.values();

    private byte[] outActions;
    private boolean[] outBooleans;
    private int[] outIntegers;
    private float[] outFloats;
    private String[] outStrings;

    private int outActionsIndex = 0;
    private int outBooleansIndex = 0;
    private int outIntegersIndex = 0;
    private int outFloatsIndex = 0;
    private int outStringsIndex = 0;

    final public Reader reader;
    final public HashMap<InAction, Action> actions = new HashMap<>();
    final private HashMap<String, CustomFunction> customFunctions = new HashMap<>();

    public Client() {
        this.reader = new Reader();

        this.outActions = new byte[OUT_ARRAYS_VALUE];
        this.outBooleans = new boolean[OUT_ARRAYS_VALUE];
        this.outIntegers = new int[OUT_ARRAYS_VALUE];
        this.outFloats = new float[OUT_ARRAYS_VALUE];
        this.outStrings = new String[OUT_ARRAYS_VALUE];

        actions.put(InAction.CALL_FUNCTION, new Action() {
            @Override
            public void work(Reader reader) {
                final String name = reader.getString();
                final CustomFunction func = customFunctions.get(name);

                final int argsLength = reader.getInteger();
                Object[] args = new Object[argsLength];

                for (int i = 0; i < argsLength; i++) {
                    final int argType = reader.getInteger();
                    if (argType == EVENT_NULL_TYPE) {
                        args[i] = null;
                    } else if (argType == EVENT_BOOLEAN_TYPE) {
                        args[i] = reader.getBoolean();
                    } else if (argType == EVENT_FLOAT_TYPE) {
                        args[i] = reader.getFloat();
                    } else if (argType == EVENT_STRING_TYPE) {
                        args[i] = reader.getString();
                    }
                }

                if (func != null) {
                    func.work(args);
                } else {
                    Log.w("Neft", "Native function '" + name + "' not found");
                }
            }
        });

        Native.client_init(this);
    }

    public void onData(final byte[] actions, final boolean[] booleans, final int[] integers, final float[] floats, final String[] strings) {
        reader.booleans = booleans;
        reader.booleansIndex = 0;
        reader.integers = integers;
        reader.integersIndex = 0;
        reader.floats = floats;
        reader.floatsIndex = 0;
        reader.strings = strings;
        reader.stringsIndex = 0;

        final int length = actions.length;
        for (int i = 0; i < length; i++){
            final InAction actionType = InActionValues[actions[i]];
            final Action action = this.actions.get(actionType);
            if (action != null) {
                action.work(reader);
            } else {
                Log.e("Neft", "Native action '" + actionType + "' is not implemented");
            }
        }

        sendData();
    }

    public void pushAction(OutAction val) {
        if (outActionsIndex == outActions.length){
            final byte[] newArray = new byte[outActionsIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outActions, 0, newArray, 0, outActionsIndex);
            outActions = newArray;
        }
        outActions[outActionsIndex++] = (byte) val.ordinal();
    }

    public void pushBoolean(boolean val) {
        if (outBooleansIndex == outBooleans.length){
            final boolean[] newArray = new boolean[outBooleansIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outBooleans, 0, newArray, 0, outBooleansIndex);
            outBooleans = newArray;
        }
        outBooleans[outBooleansIndex++] = val;
    }

    public void pushInteger(int val) {
        if (outIntegersIndex == outIntegers.length){
            final int[] newArray = new int[outIntegersIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outIntegers, 0, newArray, 0, outIntegersIndex);
            outIntegers = newArray;
        }
        outIntegers[outIntegersIndex++] = val;
    }

    public void pushFloat(float val) {
        if (outFloatsIndex == outFloats.length){
            final float[] newArray = new float[outFloatsIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outFloats, 0, newArray, 0, outFloatsIndex);
            outFloats = newArray;
        }
        outFloats[outFloatsIndex++] = val;
    }

    public void pushString(String val) {
        if (outStringsIndex == outStrings.length){
            final String[] newArray = new String[outStringsIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outStrings, 0, newArray, 0, outStringsIndex);
            outStrings = newArray;
        }
        outStrings[outStringsIndex++] = val;
    }

    public void pushEvent(String name, Object[] args) {
        pushAction(OutAction.EVENT);
        pushString(name);
        if (args != null) {
            final int length = args.length;
            pushInteger(length);
            for (Object arg : args) {
                if (arg == null) {
                    pushInteger(EVENT_NULL_TYPE);
                } else if (arg instanceof Boolean) {
                    pushInteger(EVENT_BOOLEAN_TYPE);
                    pushBoolean((Boolean) arg);
                } else if (arg instanceof Float) {
                    pushInteger(EVENT_FLOAT_TYPE);
                    pushFloat((Float) arg);
                } else if (arg instanceof String) {
                    pushInteger(EVENT_STRING_TYPE);
                    pushString((String) arg);
                } else {
                    pushInteger(EVENT_NULL_TYPE);
                    Log.e("Neft", "Event can be pushed with a boolean, float or a string, but `"+arg+"` given");
                }
            }
        } else {
            pushInteger(0);
        }
    }

    public void addCustomFunction(String name, CustomFunction func) {
        assert name.length() > 0;
        assert !customFunctions.containsKey(name);
        assert func != null;

        customFunctions.put(name, func);
    }

    public void sendData() {
        if (outActionsIndex > 0){
            final int outActionsIndex = this.outActionsIndex;
            final int outBooleansIndex = this.outBooleansIndex;
            final int outIntegersIndex = this.outIntegersIndex;
            final int outFloatsIndex = this.outFloatsIndex;
            final int outStringsIndex = this.outStringsIndex;
            this.outActionsIndex = this.outBooleansIndex = 0;
            this.outIntegersIndex = this.outFloatsIndex = this.outStringsIndex = 0;
            Native.client_sendData(outActions, outActionsIndex,
                    outBooleans, outBooleansIndex, outIntegers, outIntegersIndex,
                    outFloats, outFloatsIndex, outStrings, outStringsIndex);
        }
    }
}
