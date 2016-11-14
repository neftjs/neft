package io.neft.renderer;

import android.graphics.Color;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import java.util.HashMap;

import io.neft.App;
import io.neft.client.Action;
import io.neft.client.CustomFunction;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.Reader;
import io.neft.MainActivity;
import io.neft.client.annotation.OnAction;
import io.neft.renderer.annotation.Parser;
import io.neft.utils.StringUtils;

public class NativeItem extends Item {
    public static HashMap<String, Class<? extends NativeItem>> types = new HashMap<>();
    public static HashMap<Class<? extends NativeItem>, String> classTypes = new HashMap<>();

    public static void registerItem(Class<? extends NativeItem> clazz) {
        Parser.registerHandlers(clazz);
    }

    @OnAction(InAction.CREATE_NATIVE_ITEM)
    public static void createNativeItem(Reader reader)
            throws IllegalAccessException, InstantiationException {
        String type = reader.getString();
        Class clazz = types.get(type);
        if (clazz == null) {
            Log.w("Neft", "Native Item '" + type + "' type not found");
            new NativeItem(null);
        } else {
            clazz.newInstance();
        }
    }

    protected static class ClientHandler {
        public void work(NativeItem item, Object[] args) {}
    }

    protected static void addClientAction(final MainActivity app, String type, String name, String subName, final ClientHandler handler) {
        String eventName = "renderer" + type + StringUtils.capitalize(name) + StringUtils.capitalize(subName);
        app.client.addCustomFunction(eventName, new CustomFunction() {
            @Override
            public void work(Object[] args) {
                final NativeItem item = (NativeItem) app.renderer.items.get(Math.round((float) args[0]));
                Object[] handlerArgs = new Object[args.length - 1];
                System.arraycopy(args, 1, handlerArgs, 0, handlerArgs.length);
                handler.work(item, handlerArgs);
            }
        });
    }

    protected static void addClientProperty(MainActivity app, String name, String subName, ClientHandler handler) {
        addClientAction(app, "Set", name, subName, handler);
    }

    protected static void addClientFunction(MainActivity app, String name, String subName, ClientHandler handler) {
        addClientAction(app, "Call", name, subName, handler);
    }

    protected final View itemView;
    protected boolean autoWidth = true;
    protected boolean autoHeight = true;

    protected NativeItem(View itemView) {
        super();
        this.itemView = itemView;
        if (itemView != null) {
            view.addView(itemView);
            itemView.setLayoutParams(new RelativeLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
            ));
            view.setLayerType(View.LAYER_TYPE_HARDWARE, null);
        }
        updateSize();
    }

    protected void pushEvent(String name, Object... args) {
        String eventName = "rendererOn"
                + StringUtils.capitalize(classTypes.get(this.getClass()))
                + StringUtils.capitalize(name);
        Object[] clientArgs;
        if (args == null) {
            clientArgs = new Object[]{this.id};
        } else {
            clientArgs = new Object[args.length + 1];
            clientArgs[0] = Float.valueOf(this.id);
            System.arraycopy(args, 0, clientArgs, 1, args.length);
        }
        App.getApp().client.pushEvent(eventName, clientArgs);
    }

    @Override
    public void setWidth(float val) {
        super.setWidth(val);
        this.autoWidth = val == 0;
        this.updateSize();
    }

    @Override
    public void setHeight(float val) {
        super.setHeight(val);
        this.autoHeight = val == 0;
        this.updateSize();
    }

    protected void updateSize() {
        if (itemView == null || (!autoWidth && !autoHeight)) {
            return;
        }
        itemView.measure(
                autoWidth ? 0 : view.getLayoutParams().width,
                autoHeight ? 0 : view.getLayoutParams().height
        );
        if (autoWidth) {
            pushWidth(itemView.getMeasuredWidth());
        }
        if (autoHeight) {
            pushHeight(itemView.getMeasuredHeight());
        }
    }

    protected void pushWidth(int val) {
        if (autoWidth && view.getLayoutParams().width != val) {
            float dpVal = pxToDp(val);
            super.setWidth(dpVal);
            pushAction(OutAction.NATIVE_ITEM_WIDTH, dpVal);
        }
    }

    protected void pushHeight(int val) {
        if (autoHeight && view.getLayoutParams().height != val) {
            float dpVal = pxToDp(val);
            super.setHeight(dpVal);
            pushAction(OutAction.NATIVE_ITEM_HEIGHT, dpVal);
        }
    }

    @OnAction(InAction.ON_NATIVE_ITEM_POINTER_PRESS)
    public void onPointerPressHandler(Reader reader) {
        this.onPointerPress(reader.getFloat(), reader.getFloat());
    }

    @OnAction(InAction.ON_NATIVE_ITEM_POINTER_RELEASE)
    public void onPointerReleaseHandler(Reader reader) {
        this.onPointerRelease(reader.getFloat(), reader.getFloat());
    }

    @OnAction(InAction.ON_NATIVE_ITEM_POINTER_MOVE)
    public void onPointerMoveHandler(Reader reader) {
        this.onPointerMove(reader.getFloat(), reader.getFloat());
    }

    protected void onPointerPress(float x, float y) {}

    protected void onPointerRelease(float x, float y) {}

    protected void onPointerMove(float x, float y) {}
}
