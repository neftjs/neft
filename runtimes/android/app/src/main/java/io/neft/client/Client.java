package io.neft.client;

import android.util.Log;

import java.util.HashMap;

import io.neft.App;
import io.neft.Native;
import io.neft.client.handlers.ActionHandler;
import io.neft.client.handlers.ReaderActionHandler;
import io.neft.utils.Consumer;
import lombok.Synchronized;

public class Client {
    private static final App APP = App.getInstance();
    private static final int OUT_ARRAYS_VALUE = 64;
    private static final int OUT_ARRAYS_INCREASE_VALUE = 24;

    private static final int EVENT_NULL_TYPE = 0;
    private static final int EVENT_BOOLEAN_TYPE = 1;
    private static final int EVENT_FLOAT_TYPE = 2;
    private static final int EVENT_STRING_TYPE = 3;

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

    public final ActionHandler[] actions = new ActionHandler[InActionValues.length];
    private final HashMap<String, Consumer<Object[]>> customFunctions = new HashMap<>();
    private final Object stackLock = new Object();

    private final class CallFunctionAction extends ReaderActionHandler {
        @Override
        public void accept(Reader reader) {
            final String name = reader.getString();
            final Consumer<Object[]> func = customFunctions.get(name);

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
                func.accept(args);
            } else {
                Log.w("Neft", "Native function '" + name + "' not found");
            }
        }
    }

    public Client() {
        this.outActions = new byte[OUT_ARRAYS_VALUE];
        this.outBooleans = new boolean[OUT_ARRAYS_VALUE];
        this.outIntegers = new int[OUT_ARRAYS_VALUE];
        this.outFloats = new float[OUT_ARRAYS_VALUE];
        this.outStrings = new String[OUT_ARRAYS_VALUE];

        onAction(InAction.CALL_FUNCTION, new CallFunctionAction());

        Native.Bridge.initClient(this);
    }

    public void onAction(InAction action, ActionHandler handler) {
        actions[action.ordinal()] = handler;
    }

    public void onData(
            byte[] actions,
            boolean[] booleans,
            int[] integers,
            float[] floats,
            String[] strings
    ) {
        Reader reader = new Reader(booleans, integers, floats, strings);
        processActions(actions, reader);
        sendData();
    }

    private void processActions(byte[] actionsArr, Reader reader) {
        for (byte actionIndex : actionsArr) {
            ActionHandler action = this.actions[actionIndex];
            if (action != null) {
                action.accept(reader);
            } else {
                Log.e("Neft", "Native action '" + InActionValues[actionIndex] + "' is not implemented");
            }
        }
    }

    @Synchronized("stackLock")
    public void pushAction(OutAction val) {
        if (outActionsIndex == outActions.length){
            final byte[] newArray = new byte[outActionsIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outActions, 0, newArray, 0, outActionsIndex);
            outActions = newArray;
        }
        outActions[outActionsIndex++] = (byte) val.ordinal();
    }

    private void pushBoolean(boolean val) {
        if (outBooleansIndex == outBooleans.length){
            final boolean[] newArray = new boolean[outBooleansIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outBooleans, 0, newArray, 0, outBooleansIndex);
            outBooleans = newArray;
        }
        outBooleans[outBooleansIndex++] = val;
    }

    private void pushInteger(int val) {
        if (outIntegersIndex == outIntegers.length){
            final int[] newArray = new int[outIntegersIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outIntegers, 0, newArray, 0, outIntegersIndex);
            outIntegers = newArray;
        }
        outIntegers[outIntegersIndex++] = val;
    }

    private void pushFloat(float val) {
        if (outFloatsIndex == outFloats.length){
            final float[] newArray = new float[outFloatsIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outFloats, 0, newArray, 0, outFloatsIndex);
            outFloats = newArray;
        }
        outFloats[outFloatsIndex++] = val;
    }

    private void pushString(String val) {
        if (outStringsIndex == outStrings.length){
            final String[] newArray = new String[outStringsIndex + OUT_ARRAYS_INCREASE_VALUE];
            System.arraycopy(outStrings, 0, newArray, 0, outStringsIndex);
            outStrings = newArray;
        }
        outStrings[outStringsIndex++] = val;
    }

    @Synchronized("stackLock")
    public void pushEvent(String name, Object... args) {
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
                    Log.e("Neft", "Event can be pushed with a boolean, float or a string, "
                            + "but '"+arg+"' of '"+arg.getClass()+"' given");
                }
            }
        } else {
            pushInteger(0);
        }
    }

    @Synchronized("stackLock")
    public void pushAction(OutAction action, Object... args) {
        pushAction(action);
        for (Object arg : args) {
            if (arg instanceof Boolean) {
                pushBoolean((Boolean) arg);
            } else if (arg instanceof Float) {
                pushFloat((Float) arg);
            } else if (arg instanceof Integer) {
                pushInteger((Integer) arg);
            } else if (arg instanceof String) {
                pushString((String) arg);
            } else {
                throw new RuntimeException("ActionHandler can be pushed with Boolean, Float or String, but '"+arg+"' given");
            }
        }
    }

    public void addCustomFunction(String name, Consumer<Object[]> func) {
        if (name.isEmpty()) {
            throw new IllegalArgumentException("Name cannot be empty");
        }
        if (customFunctions.containsKey(name)) {
            throw new IllegalArgumentException("Given name is already in use");
        }
        if (func == null) {
            throw new IllegalArgumentException("Function cannot be null");
        }

        customFunctions.put(name, func);
    }

    @Synchronized("stackLock")
    public void sendData() {
        if (outActionsIndex <= 0) {
            return;
        }
        int outActionsIndex = this.outActionsIndex;
        int outBooleansIndex = this.outBooleansIndex;
        int outIntegersIndex = this.outIntegersIndex;
        int outFloatsIndex = this.outFloatsIndex;
        int outStringsIndex = this.outStringsIndex;
        this.outActionsIndex = 0;
        this.outBooleansIndex = 0;
        this.outIntegersIndex = 0;
        this.outFloatsIndex = 0;
        this.outStringsIndex = 0;
        Native.Bridge.sendClientData(
                outActions, outActionsIndex,
                outBooleans, outBooleansIndex,
                outIntegers, outIntegersIndex,
                outFloats, outFloatsIndex,
                outStrings, outStringsIndex
        );
    }
}
