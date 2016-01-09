package io.neft.Renderer;

import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.RectF;
import android.os.SystemClock;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;

import io.neft.MainActivity;
import io.neft.Native;

abstract class Action {
    Action(){ }
    void work(Reader reader){ throw new UnsupportedOperationException(); }
}

class Reader {
    public Renderer renderer;

    public boolean[] booleans;
    public int[] integers;
    public float[] floats;
    public String[] strings;

    public int booleansIndex = 0;
    public int integersIndex = 0;
    public int floatsIndex = 0;
    public int stringsIndex = 0;

    public Reader(Renderer renderer) {
        this.renderer = renderer;
    }

    public Item getItem() {
        return renderer.items.get(integers[integersIndex++]);
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

public class Renderer extends Thread {
    private static final long MIN_FRAME_DELAY = 16;
    private static final int OUT_ARRAYS_VALUE = 64;
    private static final int OUT_ARRAYS_INCREASE_VALUE = 24;

    public enum InAction {
        DEVICE_SHOW_KEYBOARD,
        DEVICE_HIDE_KEYBOARD,

        SET_WINDOW,

        CREATE_ITEM,
        SET_ITEM_PARENT,
        INSERT_ITEM_BEFORE,
        SET_ITEM_VISIBLE,
        SET_ITEM_CLIP,
        SET_ITEM_WIDTH,
        SET_ITEM_HEIGHT,
        SET_ITEM_X,
        SET_ITEM_Y,
        SET_ITEM_Z,
        SET_ITEM_SCALE,
        SET_ITEM_ROTATION,
        SET_ITEM_OPACITY,
        SET_ITEM_BACKGROUND,

        CREATE_IMAGE,
        SET_IMAGE_SOURCE,
        SET_IMAGE_SOURCE_WIDTH,
        SET_IMAGE_SOURCE_HEIGHT,
        SET_IMAGE_FILL_MODE,
        SET_IMAGE_OFFSET_X,
        SET_IMAGE_OFFSET_Y,

        CREATE_TEXT,
        SET_TEXT,
        SET_TEXT_WRAP,
        UPDATE_TEXT_CONTENT_SIZE,
        SET_TEXT_COLOR,
        SET_TEXT_LINE_HEIGHT,
        SET_TEXT_FONT_FAMILY,
        SET_TEXT_FONT_PIXEL_SIZE,
        SET_TEXT_FONT_WORD_SPACING,
        SET_TEXT_FONT_LETTER_SPACING,
        SET_TEXT_ALIGNMENT_HORIZONTAL,
        SET_TEXT_ALIGNMENT_VERTICAL,

        LOAD_FONT,

        CREATE_RECTANGLE,
        SET_RECTANGLE_COLOR,
        SET_RECTANGLE_RADIUS,
        SET_RECTANGLE_BORDER_COLOR,
        SET_RECTANGLE_BORDER_WIDTH,

        CREATE_SCROLLABLE,
        SET_SCROLLABLE_CONTENT_ITEM,
        SET_SCROLLABLE_CONTENT_X,
        SET_SCROLLABLE_CONTENT_Y,
        ACTIVATE_SCROLLABLE
    };

    public enum OutAction {
        SCREEN_SIZE,
        SCREEN_ORIENTATION,
        NAVIGATOR_LANGUAGE,
        NAVIGATOR_ONLINE,
        DEVICE_PIXEL_RATIO,
        DEVICE_IS_PHONE,
        POINTER_PRESS,
        POINTER_RELEASE,
        POINTER_MOVE,
        DEVICE_KEYBOARD_SHOW,
        DEVICE_KEYBOARD_HIDE,
        KEY_PRESS,
        KEY_HOLD,
        KEY_INPUT,
        KEY_RELEASE,
        IMAGE_SIZE,
        TEXT_SIZE,
        FONT_LOAD,
        SCROLLABLE_CONTENT_X,
        SCROLLABLE_CONTENT_Y
    };

    final private InAction[] InActionValues = InAction.values();

    private long delay = 0;

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

    final public MainActivity mainActivity;
    final public ArrayList<Item> items;
    final private Runnable runnable;
    final public WindowView window;
    final public Device device;
    final public Screen screen;
    final public Navigator navigator;
    final public Reader reader;
    final public HashMap<InAction, Action> actions = new HashMap<>();

    public boolean dirty = true;
    public ArrayList<RectF> dirtyRects = new ArrayList<>();
    private Matrix measureMatrix = new Matrix();
    private Rect dirtyRect = new Rect();

    public Renderer(MainActivity mainActivity) {
        super();

        this.mainActivity = mainActivity;
        this.items = new ArrayList<>();
        this.runnable = new Runnable() {
            public void run() {
                onAnimationFrame();
            }
        };
        this.window = mainActivity.view;
        this.window.renderer = this;
        this.reader = new Reader(this);

        items.add(null);

        this.outActions = new byte[OUT_ARRAYS_VALUE];
        this.outBooleans = new boolean[OUT_ARRAYS_VALUE];
        this.outIntegers = new int[OUT_ARRAYS_VALUE];
        this.outFloats = new float[OUT_ARRAYS_VALUE];
        this.outStrings = new String[OUT_ARRAYS_VALUE];

        this.navigator = new Navigator(this);
        this.device = new Device(this);
        this.screen = new Screen(this);

        WindowView.register(this);
        Navigator.register(this);
        Device.register(this);
        Screen.register(this);
        Item.register(this);
        Image.register(this);
        Text.register(this);
        Rectangle.register(this);
        Scrollable.register(this);

        Native.renderer_init(this);
    }

    public float pxToDp(float px) {
        return px / device.pixelRatio;
    }

    public float dpToPx(float dp) {
        return dp * device.pixelRatio;
    }

    public void updateView(final byte[] actions, final boolean[] booleans, final int[] integers, final float[] floats, final String[] strings) {
        this.dirty = true;

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
                Log.e("Renderer", "Action '" + actionType + "' is not implemented");
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

    public void pushItem(Item val) {
        pushInteger(val.id);
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

    private void sendData() {
        if (outActionsIndex > 0){
            final int outActionsIndex = this.outActionsIndex;
            final int outBooleansIndex = this.outBooleansIndex;
            final int outIntegersIndex = this.outIntegersIndex;
            final int outFloatsIndex = this.outFloatsIndex;
            final int outStringsIndex = this.outStringsIndex;
            this.outActionsIndex = this.outBooleansIndex = 0;
            this.outIntegersIndex = this.outFloatsIndex = this.outStringsIndex = 0;
            Native.renderer_updateView(outActions, outActionsIndex,
                    outBooleans, outBooleansIndex, outIntegers, outIntegersIndex,
                    outFloats, outFloatsIndex, outStrings, outStringsIndex);
        }
    }

    public void onAnimationFrame() {
        window.postDelayed(runnable, MIN_FRAME_DELAY);
        sendData();
        Native.renderer_callAnimationFrame();
        if (dirty) {
            this.draw();
            this.dirty = false;
        }
    }

    public void run() {
        onAnimationFrame();
    }

    private void draw() {
        // measure window item
        dirtyRects.clear();
        if (mainActivity.view.windowItem != null) {
            mainActivity.view.windowItem.measure(measureMatrix, screen.rect, dirtyRects);
        }

        for (final RectF rect : dirtyRects) {
            rect.roundOut(dirtyRect);
            window.invalidate(dirtyRect);
        }
    }
}
