package io.neft.Renderer;

import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.RectF;

import java.util.ArrayList;

import io.neft.Client.Action;
import io.neft.Client.InAction;
import io.neft.Client.Reader;
import io.neft.MainActivity;
import io.neft.Utils.RectFUtils;

public class Item {
    static void register(final MainActivity app) {
        app.client.actions.put(InAction.CREATE_ITEM, new Action() {
            @Override
            public void work(Reader reader) {
                new Item(app);
            }
        });

        app.client.actions.put(InAction.SET_ITEM_PARENT, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setParent(app.renderer.getItemFromReader(reader));
            }
        });

        app.client.actions.put(InAction.INSERT_ITEM_BEFORE, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).insertBefore(app.renderer.getItemFromReader(reader));
            }
        });

        app.client.actions.put(InAction.SET_ITEM_VISIBLE, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setVisible(reader.getBoolean());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_CLIP, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setClip(reader.getBoolean());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_WIDTH, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setWidth(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_HEIGHT, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setHeight(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_X, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setX(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_Y, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setY(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_SCALE, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setScale(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_ROTATION, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setRotation(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_OPACITY, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setOpacity(reader.getInteger());
            }
        });

        app.client.actions.put(InAction.SET_ITEM_BACKGROUND, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setBackground(app.renderer.getItemFromReader(reader));
            }
        });

        app.client.actions.put(InAction.SET_ITEM_KEYS_FOCUS, new Action() {
            @Override
            public void work(Reader reader) {
                app.renderer.getItemFromReader(reader).setKeysFocus(reader.getBoolean());
            }
        });
    }

    protected final MainActivity app;

    public final int id;
    public float x = 0;
    public float y = 0;
    public float width = 0;
    public float height = 0;
    public float scale = 1f;
    public float rotation = 0f;
    public int opacity = 255;
    public boolean visible = true;
    public boolean clip = false;
    public Item parent;
    public Item background;
    public final ArrayList<Item> children;

    public final Matrix matrix = new Matrix();
    protected final float[] matrixValues = new float[]{0, 0, 0, 0, 0, 0, 0, 0, 1};
    protected boolean dirtyMatrix = false;

    protected boolean dirty = false;
    protected boolean dirtyChildren = false;
    public final RectF bounds = new RectF();
    public final RectF globalBounds = new RectF();
    protected final RectF oldGlobalBounds = new RectF();
    protected final Matrix globalMatrix = new Matrix();
    protected final RectF redrawRect = new RectF();

    public Item(MainActivity app) {
        this.app = app;
        this.id = app.renderer.items.size();
        app.renderer.items.add(this);

        children = new ArrayList<>();
    }

    protected void invalidate() {
        if (this.dirty){
            return;
        }
        this.dirty = true;
        Item parent = this.parent;
        while (parent != null && !parent.dirtyChildren){
            parent.dirtyChildren = true;
            parent = parent.parent;
        }
    }

    protected void updateMatrix() {
        float a = 1;
        float b = 0;
        float c = 0;
        float d = 1;
        float tx = 0;
        float ty = 0;

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

    public void setParent(Item val) {
        if (parent != null){
            parent.children.remove(this);
            parent.invalidate();
        }

        if (val != null){
            val.children.add(this);
            val.invalidate();
        }

        this.parent = val;
        invalidate();
    }

    public void insertBefore(Item val) {
        if (parent != null){
            parent.children.remove(this);
            parent.invalidate();
        }

        final Item parent = val.parent;
        final int index = parent.children.indexOf(val);
        parent.children.add(index, this);
        parent.invalidate();
        this.parent = parent;
        invalidate();
    }

    public void setVisible(boolean val) {
        visible = val;
        invalidate();
    }

    public void setClip(boolean val) {
        clip = val;
        invalidate();
    }

    public void setWidth(float val) {
        width = app.renderer.dpToPx(val);
        bounds.right = width;
        dirtyMatrix = true;
        invalidate();
    }

    public void setHeight(float val) {
        height = app.renderer.dpToPx(val);
        bounds.bottom = height;
        dirtyMatrix = true;
        invalidate();
    }

    public void setX(float val) {
        x = app.renderer.dpToPx(val);
        dirtyMatrix = true;
        invalidate();
    }

    public void setY(float val) {
        y = app.renderer.dpToPx(val);
        dirtyMatrix = true;
        invalidate();
    }

    public void setScale(float val) {
        scale = val;
        dirtyMatrix = true;
        invalidate();
    }

    public void setRotation(float val) {
        rotation = val;
        dirtyMatrix = true;
        invalidate();
    }

    public void setOpacity(int val) {
        opacity = val;
        invalidate();
    }

    public void setBackground(Item val) {
        background = val;
        invalidate();
    }

    public void setKeysFocus(boolean val) {

    }

    protected void measure(final Matrix globalMatrix, RectF viewRect, final ArrayList<RectF> dirtyRects, final boolean forceUpdateBounds) {
        final boolean isDirty = forceUpdateBounds || dirty || dirtyMatrix;

        // break on no changes
        if (!dirtyChildren && !isDirty) {
            return;
        }

        // update transform
        if (dirtyMatrix) {
            updateMatrix();
        }

        // include local transform
        this.globalMatrix.setConcat(globalMatrix, matrix);

        // update bounds
        if (isDirty) {
            oldGlobalBounds.set(globalBounds);
            globalBounds.set(bounds);
            this.globalMatrix.mapRect(globalBounds);

            // add rectangle to redraw
            if (dirty || dirtyMatrix || !RectFUtils.equals(globalBounds, oldGlobalBounds)) {
                redrawRect.set(oldGlobalBounds);
                redrawRect.union(globalBounds);
                if (redrawRect.intersect(viewRect)) {
                    boolean redrawRectIncluded = false;
                    for (final RectF dirtyRect : dirtyRects) {
                        if (RectF.intersects(dirtyRect, redrawRect)) {
                            dirtyRect.union(redrawRect);
                            redrawRectIncluded = true;
                            break;
                        }
                    }
                    if (!redrawRectIncluded) {
                        dirtyRects.add(redrawRect);
                    }
                }

                dirty = false;
            }
        }

        // clip
        if (clip) {
            viewRect = globalBounds;
        }

        final boolean forceChildrenUpdate = forceUpdateBounds || dirtyMatrix;
        if (forceChildrenUpdate || dirtyChildren) {
            // clear
            dirtyChildren = false;
            dirtyMatrix = false;

            // measure background
            if (background != null) {
                background.measure(this.globalMatrix, viewRect, dirtyRects, forceChildrenUpdate);
            }

            // measure children
            for (final Item child : children) {
                child.measure(this.globalMatrix, viewRect, dirtyRects, forceChildrenUpdate);
            }
        }
    }

    protected void measure(final Matrix globalMatrix, final RectF viewRect, final ArrayList<RectF> dirtyRects) {
        measure(globalMatrix, viewRect, dirtyRects, false);
    }

    protected void drawShape(final Canvas canvas, final int alpha) {

    }

    protected void draw(final Canvas canvas, int alpha, final RectF rect) {
        if (opacity < 255) {
            alpha = Math.round(alpha * (opacity / 255f));
        }

        canvas.save();

        // transform
        canvas.concat(matrix);

        // clip
        if (clip){
            canvas.clipRect(0, 0, width, height);
        }

        // background
        if (background != null){
            background.draw(canvas, alpha, rect);
        }

        // shape
        if (RectF.intersects(rect, globalBounds)) {
            drawShape(canvas, alpha);
        }

        // render children
        for (final Item child : children){
            if (child.visible) {
                child.draw(canvas, alpha, rect);
            }
        }

        canvas.restore();
    }
}
