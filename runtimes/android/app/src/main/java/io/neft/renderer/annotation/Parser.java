package io.neft.renderer.annotation;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import io.neft.App;
import io.neft.client.CustomFunction;
import io.neft.renderer.NativeItem;
import io.neft.utils.ColorValue;
import io.neft.utils.StringUtils;

public final class Parser {
    private static void invokeMethod(Method method, NativeItem item, Object[] args) throws InvocationTargetException, IllegalAccessException {
        Class[] parameterTypes = method.getParameterTypes();
        Class arg = parameterTypes.length > 0 ? parameterTypes[0] : null;

        if (parameterTypes.length > 1) {
            throw new RuntimeException("Method " + method.getName() + " has more than 1 parameter");
        }

        if (arg == null) {
            method.invoke(item);
        } else if (arg == Object[].class) {
            method.invoke(item, args);
        } else if (arg == boolean.class) {
            method.invoke(item, (boolean) args[0]);
        } else if (arg == float.class) {
            method.invoke(item, (float) args[0]);
        } else if (arg == int.class) {
            method.invoke(item, Math.round((float) args[0]));
        } else if (arg == ColorValue.class) {
            if (args[0] == null) {
                method.invoke(item, (Object) null);
            } else {
                int val = Float.floatToIntBits((float) args[0]);
                int argb = ColorValue.RGBAtoARGB(val);
                method.invoke(item, new ColorValue(argb));
            }
        } else if (arg == String.class) {
            method.invoke(item, (String) args[0]);
        } else {
            throw new RuntimeException("Not supported method " + method.getName() + " parameters");
        }
    }

    private static void registerHandler(String type, String value, final Method method, String clazzType) {
        String eventName = "renderer"
                + type
                + StringUtils.capitalize(clazzType)
                + StringUtils.capitalize(value);
        App.getApp().client.addCustomFunction(eventName, new CustomFunction() {
            @Override
            public void work(Object[] args) {
                int itemId = Math.round((float) args[0]);
                NativeItem item = (NativeItem) App.getApp().renderer.items.get(itemId);
                Object[] handlerArgs = new Object[args.length - 1];
                System.arraycopy(args, 1, handlerArgs, 0, handlerArgs.length);
                try {
                    invokeMethod(method, item, handlerArgs);
                } catch (InvocationTargetException err) {
                    throw new RuntimeException("Cannot call args `"+args+"` on "+method.getName()+" method", err);
                } catch (IllegalAccessException err) {
                    new RuntimeException(err);
                }
            }
        });
    }

    public static void registerHandlers(Class<? extends NativeItem> clazz) {
        // onCreate
        Constructor ctor = null;
        try {
            ctor = clazz.getDeclaredConstructor();
        } catch (NoSuchMethodException e) {
            return;
        }
        String clazzType = ((OnCreate) ctor.getAnnotation(OnCreate.class)).value();
        NativeItem.types.put(clazzType, clazz);
        NativeItem.classTypes.put(clazz, clazzType);

        // OnSet, OnCall
        Method[] methods = clazz.getDeclaredMethods();
        for (Method method : methods) {
            OnSet onSet = method.getAnnotation(OnSet.class);
            if (onSet != null) {
                registerHandler("Set", onSet.value(), method, clazzType);
            }

            OnCall onCall = method.getAnnotation(OnCall.class);
            if (onCall != null) {
                registerHandler("Call", onCall.value(), method, clazzType);
            }
        }
    }
}
