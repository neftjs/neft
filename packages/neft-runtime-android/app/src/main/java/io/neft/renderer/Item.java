package io.neft.renderer;

import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.RectF;
import android.view.View;
import android.view.ViewGroup;
import io.neft.App;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.Reader;
import io.neft.client.handlers.ActionHandler;
import io.neft.client.handlers.NoArgsActionHandler;
import io.neft.client.handlers.ReaderActionHandler;
import io.neft.renderer.handlers.*;

import java.util.ArrayList;
import java.util.List;

public class Item {
    protected static final App APP = App.getInstance();
    protected static final int MAX_GPU_WIDTH = 1280;
    protected static final int MAX_GPU_HEIGHT = 960;
    private static final RectF TEMP_RECT_F = new RectF();
    private static final int LAYER_MIN_OPERATIONS = 5;
    private static final int LAYER_GC_DELAY = 5000;
    private static final List<Item> LAYERS = new ArrayList<>();
    private static long lastGcTime = 0;

    protected static void onAction(InAction action, ActionHandler handler) {
        APP.getClient().onAction(action, handler);
    }

    protected static <T extends Item> void onAction(InAction action, final ItemActionHandler handler) {
        onAction(action, new ReaderActionHandler() {
            @Override
            public void accept(Reader reader) {
                T item = (T) APP.getRenderer().getItemFromReader(reader);
                handler.accept(item, reader);
            }
        });
    }

    public static void register() {
        onAction(InAction.CREATE_ITEM, new NoArgsActionHandler() {
            @Override
            public void accept() {
                new Item();
            }
        });

        onAction(InAction.SET_ITEM_PARENT, new ItemItemActionHandler() {
            @Override
            public void accept(Item item, Item value) {
                item.setParent(value);
            }
        });

        onAction(InAction.INSERT_ITEM_BEFORE, new ItemItemActionHandler() {
            @Override
            public void accept(Item item, Item value) {
                item.insertBefore(value);
            }
        });

        onAction(InAction.SET_ITEM_VISIBLE, new BooleanItemActionHandler() {
            @Override
            public void accept(Item item, boolean value) {
                item.setVisible(value);
            }
        });

        onAction(InAction.SET_ITEM_CLIP, new BooleanItemActionHandler() {
            @Override
            public void accept(Item item, boolean value) {
                item.setClip(value);
            }
        });

        onAction(InAction.SET_ITEM_WIDTH, new FloatItemActionHandler() {
            @Override
            public void accept(Item item, float value) {
                item.setWidth(value);
            }
        });

        onAction(InAction.SET_ITEM_HEIGHT, new FloatItemActionHandler() {
            @Override
            public void accept(Item item, float value) {
                item.setHeight(value);
            }
        });

        onAction(InAction.SET_ITEM_X, new FloatItemActionHandler() {
            @Override
            public void accept(Item item, float value) {
                item.setX(value);
            }
        });

        onAction(InAction.SET_ITEM_Y, new FloatItemActionHandler() {
            @Override
            public void accept(Item item, float value) {
                item.setY(value);
            }
        });

        onAction(InAction.SET_ITEM_SCALE, new FloatItemActionHandler() {
            @Override
            public void accept(Item item, float value) {
                item.setScale(value);
            }
        });

        onAction(InAction.SET_ITEM_ROTATION, new FloatItemActionHandler() {
            @Override
            public void accept(Item item, float value) {
                item.setRotation(value);
            }
        });

        onAction(InAction.SET_ITEM_OPACITY, new IntItemActionHandler() {
            @Override
            public void accept(Item item, int value) {
                item.setOpacity(value);
            }
        });

        onAction(InAction.SET_ITEM_KEYS_FOCUS, new BooleanItemActionHandler() {
            @Override
            public void accept(Item item, boolean value) {
                item.setKeysFocus(value);
            }
        });
    }

    // basic properties
    final int id;
    private int x = 0;
    private int y = 0;
    private int width = 0;
    private int height = 0;
    private float scale = 1f;
    private float rotation = 0f;
    private boolean visible = true;
    private boolean clip = false;
    private final ArrayList<Item> children = new ArrayList<>();

    // matrix
    private final Matrix matrix = new Matrix();
    private final float[] matrixValues = new float[] {0, 0, 0, 0, 0, 0, 0, 0, 1};
    private boolean dirtyMatrix = false;

    // measurement
    private boolean dirtyChildren = false;
    private final Rect size = new Rect();
    private final Rect bounds = new Rect();
    private final Rect childrenBounds = new Rect();
    private final Rect takenBounds = new Rect();
    private boolean optimized = false;
    private boolean childrenOptimized = false;

    // hardware layers
    private boolean isInLayers = false;
    private boolean isLayer = false;
    private long operations = 0;

    // android view
    public final ItemView view;
    private Item parent;
    private Rect clipRect;

    public static void onAnimationFrame() {
        long now = System.currentTimeMillis();
        if (now - lastGcTime < LAYER_GC_DELAY) {
            return;
        }

        lastGcTime = now;

        int size = LAYERS.size();
        for (int i = 0; i < size; i++) {
            Item item = LAYERS.get(i);
            item.operations *= 0.4;
            if (item.operations < LAYER_MIN_OPERATIONS) {
                item.dropGpu();
                i -= 1;
                size -= 1;
            }
        }
    }

    protected Item(ItemView view) {
        this.view = view;
        view.setLayoutParams(new ItemView.LayoutParams(0, 0));
        this.id = APP.getRenderer().registerItem(this);
        view.itemId = this.id;
        view.setClipChildren(optimized);
    }

    public Item() {
        this(new ItemView(APP.getWindowView().getContext()));
    }

    private void invalidate() {
        Item parent = this.parent;
        while (parent != null && !parent.dirtyChildren){
            parent.dirtyChildren = true;
            parent = parent.parent;
        }
    }

    private void updateMatrix() {
        float a, b = 0, c = 0, d, tx, ty;

        final float originX = width / 2;
        final float originY = height / 2;

        // translate to the origin
        tx = x + originX;
        ty = y + originY;

        // scale
        a = scale;
        d = scale;

        // rotate
        if (rotation != 0) {
            final float sr = (float) Math.sin(rotation);
            final float cr = (float) Math.cos(rotation);

            final float ac = a;
            final float dc = d;

            a = ac * cr;
            b = dc * sr;
            c = ac * -sr;
            d = dc * cr;
        }

        // translate to the position
        tx += a * -originX + c * -originY;
        ty += b * -originX + d * -originY;

        // save
        matrixValues[0] = a;
        matrixValues[1] = c;
        matrixValues[2] = tx;
        matrixValues[3] = b;
        matrixValues[4] = d;
        matrixValues[5] = ty;
        matrix.setValues(matrixValues);
    }

    protected int dpToPx(float dp) {
        return APP.getRenderer().dpToPx(dp);
    }

    protected float pxToDp(float px) {
        return APP.getRenderer().pxToDp(px);
    }

    void pushAction(OutAction action, Object... args) {
        Object[] localArgs = new Object[args.length + 1];
        System.arraycopy(args, 0, localArgs, 1, args.length);
        localArgs[0] = id;
        APP.getClient().pushAction(action, localArgs);
    }

    public void removeFromParent() {
        if (parent != null) {
            parent.view.removeView(view);
            parent.children.remove(this);
            parent.invalidate();
        }
        parent = null;
    }

    public void setParent(Item val) {
        removeFromParent();

        if (val != null) {
            val.children.add(this);
            val.view.addView(view);
            val.invalidate();
        }

        parent = val;
        invalidate();
    }

    public void insertBefore(Item val) {
        removeFromParent();

        Item newParent = val.parent;

        newParent.children.add(this);
        ViewGroup viewParent = newParent.view;
        int index = viewParent.indexOfChild(val.view);
        viewParent.addView(view, index);
        newParent.invalidate();

        parent = newParent;
        invalidate();
    }

    public void setVisible(boolean val) {
        this.visible = val;
        view.setVisibility(val ? View.VISIBLE : View.GONE);
        invalidate();
    }

    public void setClip(boolean val) {
        clip = val;
        clipRect = val ? new Rect() : null;
        reloadClipBounds();
        invalidate();
    }

    private void reloadClipBounds() {
        if (clipRect != null) {
            clipRect.right = Math.round(width);
            clipRect.bottom = Math.round(height);
        }
        view.setClipBounds(clipRect);
    }

    public void setWidth(float val) {
        width = dpToPx(val);
        size.right = width;
        dirtyMatrix = true;
        view.getLayoutParams().width = width;
        view.requestLayout();
        reloadClipBounds();
        invalidate();
    }

    public void setHeight(float val) {
        height = dpToPx(val);
        size.bottom = height;
        dirtyMatrix = true;
        view.getLayoutParams().height = height;
        view.requestLayout();
        reloadClipBounds();
        invalidate();
    }

    public void setX(float val) {
        x = dpToPx(val);
        dirtyMatrix = true;
        view.setTranslationX(x);
        invalidate();
        useGpu();
    }

    public void setY(float val) {
        y = dpToPx(val);
        dirtyMatrix = true;
        view.setTranslationY(y);
        invalidate();
        useGpu();
    }

    public void setScale(float val) {
        scale = val;
        dirtyMatrix = true;
        view.setScaleX(val);
        view.setScaleY(val);
        invalidate();
        useGpu();
    }

    public void setRotation(float val) {
        rotation = val;
        dirtyMatrix = true;
        view.setRotation((float) Math.toDegrees(val));
        invalidate();
        useGpu();
    }

    public void setOpacity(int val) {
        view.setAlpha(val / 255f);
        useGpu();
    }

    public void setKeysFocus(boolean val) {}

    private boolean canUseGpu() {
        return optimized && width <= MAX_GPU_WIDTH && height <= MAX_GPU_HEIGHT;
    }

    private void useGpu() {
        if (!optimized) {
            return;
        }
        if (!isInLayers) {
            LAYERS.add(this);
            isInLayers = true;
        }
        if (!isLayer && operations >= LAYER_MIN_OPERATIONS) {
            setUseHardwareLayer(true);
            isLayer = true;
        } else {
            operations += 1;
        }
    }

    private void dropGpu() {
        operations = 0;
        if (isInLayers) {
            LAYERS.remove(this);
            isInLayers = false;
        }
        if (isLayer) {
            setUseHardwareLayer(false);
            isLayer = false;
        }
    }

    private void setUseHardwareLayer(boolean val) {
        view.setLayerType(val ? View.LAYER_TYPE_HARDWARE : View.LAYER_TYPE_NONE, null);
    }

    public void measure() {
        // break on no changes
        if (!dirtyChildren && !dirtyMatrix) {
            return;
        }

        // update transform and bounds
        if (dirtyMatrix) {
            updateMatrix();
            bounds.set(size);
            TEMP_RECT_F.set(bounds);
            matrix.mapRect(TEMP_RECT_F);
            TEMP_RECT_F.roundOut(bounds);
            dirtyMatrix = false;
        }

        // measure children
        if (dirtyChildren) {
            childrenOptimized = true;
            childrenBounds.setEmpty();
            for (int i = 0, len = children.size(); i < len; i++) {
                Item child = children.get(i);
                if (child.visible) {
                    child.measure();
                    if (!child.optimized) {
                        childrenOptimized = false;
                    }
                    childrenBounds.union(child.takenBounds);
                }
            }
            dirtyChildren = false;
        }

        // update taken bounds by itself and children
        takenBounds.setEmpty();
        takenBounds.union(bounds);
        if (!clip) takenBounds.union(childrenBounds);

        // optimize if possible
        boolean optimize = clip || size.contains(childrenBounds);
        optimize = optimize && canUseGpu();
        if (visible && optimized != optimize) {
            optimized = optimize;
            view.setClipChildren(optimized && childrenOptimized);
            if (!optimized) {
                dropGpu();
            }
        }
    }
}
