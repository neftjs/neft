package io.neft.renderer.annotation;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import io.neft.App;
import io.neft.client.CustomFunction;
import io.neft.renderer.Item;
import io.neft.renderer.NativeItem;
import io.neft.utils.ColorValue;
import io.neft.utils.StringUtils;

public final class Parser {
    private static final App APP = App.getInstance();

    private static Object[] getMethodCallArgs(Class[] parameterTypes, Object[] args) {
        Class arg = parameterTypes.length > 0 ? parameterTypes[0] : null;

        if (parameterTypes.length > 1) {
            throw new IllegalArgumentException("Method has more than 1 parameter");
        }

        if (arg == null) {
            return new Object[] {};
        } else if (arg == Object[].class) {
            return new Object[] {args};
        } else if (arg == boolean.class) {
            return new Object[] {args[0]};
        } else if (arg == float.class) {
            return new Object[] {args[0]};
        } else if (arg == int.class) {
            return new Object[] {Math.round((float) args[0])};
        } else if (arg == ColorValue.class) {
            if (args[0] == null) {
                return new Object[1];
            } else {
                int val = Float.floatToIntBits((float) args[0]);
                int argb = ColorValue.RGBAtoARGB(val);
                return new Object[] {new ColorValue(argb)};
            }
        } else if (arg == String.class) {
            return new Object[]{args[0]};
        } else if (arg == Item.class) {
            Integer id = args[0] == null ? 0 : Math.round((float) args[0]);
            if (id <= 0) {
                return new Object[1];
            } else {
                return new Object[] {APP.getRenderer().getItemById(id)};
            }
        } else {
            throw new IllegalArgumentException("Method parameters not supported");
        }
    }

    private static void registerHandler(String type, String value, final Method method, String clazzType) {
        String eventName = "renderer"
                + type
                + StringUtils.capitalize(clazzType)
                + StringUtils.capitalize(value);
        final Class[] parameterTypes = method.getParameterTypes();
        try {
            getMethodCallArgs(parameterTypes, new Object[]{0});
        } catch (IllegalArgumentException err) {
            throw new RuntimeException("Cannot apply " + type + " annotation on " + method.getName(), err);
        } catch (RuntimeException err) {
            // NOP
        }
        APP.getClient().addCustomFunction(eventName, new CustomFunction() {
            @Override
            public void work(Object[] args) {
                int itemId = Math.round((float) args[0]);
                NativeItem item = (NativeItem) APP.getRenderer().getItemById(itemId);
                Object[] handlerArgs = new Object[args.length - 1];
                System.arraycopy(args, 1, handlerArgs, 0, handlerArgs.length);
                try {
                    method.invoke(item, getMethodCallArgs(parameterTypes, handlerArgs));
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
        Constructor ctor;
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
