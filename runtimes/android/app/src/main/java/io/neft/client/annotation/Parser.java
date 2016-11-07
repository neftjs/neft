package io.neft.client.annotation;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;

import io.neft.App;
import io.neft.client.Action;
import io.neft.client.InAction;
import io.neft.client.Reader;
import io.neft.renderer.Item;
import io.neft.utils.ColorValue;

public final class Parser {
    private static void invoke(Method method, Object receiver, Object... args) {
        try {
            method.invoke(receiver, args);
        } catch (IllegalAccessException err) {
            throw new RuntimeException("Cannot call args `"+args+"` on "+method.getName()+" method", err);
        } catch (InvocationTargetException err) {
            throw new RuntimeException(err);
        }
    }

    private static Action getStaticHandlerWithReader(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                invoke(method, null, reader);
            }
        };
    }

    private static Action getStaticHandler(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                invoke(method, null);
            }
        };
    }

    private static Action getHandlerWithReader(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                invoke(method, item, reader);
            }
        };
    }

    private static Action getHandler(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                invoke(method, item);
            }
        };
    }

    private static Action getHandlerWithItem(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                Item val = App.getApp().renderer.getItemFromReader(reader);
                invoke(method, item, val);
            }
        };
    }

    private static Action getHandlerWithBoolean(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                invoke(method, item, reader.getBoolean());
            }
        };
    }

    private static Action getHandlerWithFloat(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                invoke(method, item, reader.getFloat());
            }
        };
    }

    private static Action getHandlerWithInteger(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                invoke(method, item, reader.getInteger());
            }
        };
    }

    private static Action getHandlerWithColor(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                int rgba = reader.getInteger();
                int argb = ColorValue.RGBAtoARGB(rgba);
                ColorValue color = new ColorValue(argb);
                invoke(method, item, color);
            }
        };
    }

    private static Action getHandlerWithString(final Method method) {
        return new Action() {
            @Override
            public void work(Reader reader) {
                Item item = App.getApp().renderer.getItemFromReader(reader);
                invoke(method, item, reader.getString());
            }
        };
    }

    private static void registerHandler(InAction actionType, final Method method) {
        Action action;
        Class[] parameterTypes = method.getParameterTypes();
        boolean isStatic = Modifier.isStatic(method.getModifiers());

        if (isStatic && Arrays.equals(parameterTypes, new Class[]{Reader.class})) {
            action = getStaticHandlerWithReader(method);
        } else if (isStatic && parameterTypes.length == 0) {
            action = getStaticHandler(method);
        } else if (!isStatic && Arrays.equals(parameterTypes, new Class[]{Reader.class})) {
            action = getHandlerWithReader(method);
        } else if (!isStatic && parameterTypes.length == 0) {
            action = getHandler(method);
        } else if (!isStatic && Arrays.equals(parameterTypes, new Class[]{Item.class})) {
            action = getHandlerWithItem(method);
        } else if (!isStatic && Arrays.equals(parameterTypes, new Class[]{boolean.class})) {
            action = getHandlerWithBoolean(method);
        } else if (!isStatic && Arrays.equals(parameterTypes, new Class[]{float.class})) {
            action = getHandlerWithFloat(method);
        } else if (!isStatic && Arrays.equals(parameterTypes, new Class[]{int.class})) {
            action = getHandlerWithInteger(method);
        } else if (!isStatic && Arrays.equals(parameterTypes, new Class[]{ColorValue.class})) {
            action = getHandlerWithColor(method);
        } else if (!isStatic && Arrays.equals(parameterTypes, new Class[]{String.class})) {
            action = getHandlerWithString(method);
        } else {
            throw new RuntimeException("OnAction method parameters not supported; on " + method.getName());
        }

        App.getApp().client.actions.put(actionType, action);
    }

    public static void registerHandlers(Class clazz) {
        Method[] methods = clazz.getDeclaredMethods();
        for (Method method : methods) {
            OnAction annotation = method.getAnnotation(OnAction.class);
            if (annotation != null) {
                registerHandler(annotation.value(), method);
            }
        }
    }
}
