package io.neft.renderer;

import android.util.Log;
import android.view.View;

import java.util.HashMap;

import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.Reader;
import io.neft.MainActivity;
import io.neft.client.handlers.StringActionHandler;
import io.neft.renderer.annotation.Parser;
import io.neft.renderer.handlers.ReaderItemActionHandler;
import io.neft.utils.Consumer;
import io.neft.utils.StringUtils;

public class NativeItem extends Item {
    public static final HashMap<String, Class<? extends NativeItem>> types = new HashMap<>();
    public static HashMap<Class<? extends NativeItem>, String> classTypes = new HashMap<>();

    public static void register() {
        onAction(InAction.CREATE_NATIVE_ITEM, new StringActionHandler() {
            @Override
            public void accept(String value) {
                createNativeItem(value);
            }
        });

        onAction(InAction.ON_NATIVE_ITEM_POINTER_PRESS, new ReaderItemActionHandler<NativeItem>() {
            @Override
            public void accept(NativeItem item, Reader reader) {
                item.onPointerPress(reader.getFloat(), reader.getFloat());
            }
        });

        onAction(InAction.ON_NATIVE_ITEM_POINTER_RELEASE, new ReaderItemActionHandler<NativeItem>() {
            @Override
            public void accept(NativeItem item, Reader reader) {
                item.onPointerRelease(reader.getFloat(), reader.getFloat());
            }
        });

        onAction(InAction.ON_NATIVE_ITEM_POINTER_MOVE, new ReaderItemActionHandler<NativeItem>() {
            @Override
            public void accept(NativeItem item, Reader reader) {
                item.onPointerMove(reader.getFloat(), reader.getFloat());
            }
        });
    }

    public static void registerItem(Class<? extends NativeItem> clazz) {
        Parser.registerHandlers(clazz);
    }

    public static void createNativeItem(String type) {
        Class clazz = types.get(type);
        if (clazz == null) {
            Log.w("Neft", "Native Item '" + type + "' type not found");
            new NativeItem(null);
        } else {
            try {
                clazz.newInstance();
            } catch (InstantiationException error) {
                error.printStackTrace();
                new NativeItem(null);
            } catch (IllegalAccessException error) {
                error.printStackTrace();
                new NativeItem(null);
            }
        }
    }

    private static class ClientHandler {
        public void work(NativeItem item, Object[] args) {}
    }

    protected static void addClientAction(final MainActivity app, String type, String name, String subName, final ClientHandler handler) {
        String eventName = "renderer" + type + StringUtils.capitalize(name) + StringUtils.capitalize(subName);
        APP.getClient().addCustomFunction(eventName, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] args) {
                final NativeItem item = (NativeItem) APP.getRenderer().getItemById(Math.round((float) args[0]));
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
            clientArgs[0] = (float) this.id;
            System.arraycopy(args, 0, clientArgs, 1, args.length);
        }
        APP.getClient().pushEvent(eventName, clientArgs);
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

    protected void onPointerPress(float x, float y) {}

    protected void onPointerRelease(float x, float y) {}

    protected void onPointerMove(float x, float y) {}

    @Override
    public void setKeysFocus(boolean val) {
        super.setKeysFocus(val);
        if (val) {
            itemView.requestFocus();
        } else {
            itemView.clearFocus();
        }
    }
}
