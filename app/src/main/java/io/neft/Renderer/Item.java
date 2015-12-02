package io.neft.Renderer;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.util.Log;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsoluteLayout;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.lang.Integer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Item {
    protected final Renderer renderer;

    public final int id;
    public float x = 0;
    public float y = 0;
    public float width = 0;
    public float height = 0;
    public float scale = 1f;
    public float rotation = 0f;
    public int opacity = 255;
    public int zIndex = 0;
    public boolean visible = true;
    public boolean clip = false;
    public Item parent;
    public Item background;

    // children array is used only if item contains children with custom z-index
    public ArrayList<Item> children;

    public int childrenWithZIndex = 0;
    public final ArrayList<Item> childrenByZIndex;

    private static final float PI = (float) Math.PI;

    private static final Comparator<Item> zIndexComparator = new Comparator<Item>(){
        public int compare(Item a, Item b){
            return b.zIndex - a.zIndex;
        }
    };

    static void register(Renderer renderer){
        renderer.actions.put(Renderer.InAction.CREATE_ITEM, new Action() {
            @Override
            void work(Reader reader) {
                new Item(reader.renderer);
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_PARENT, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setParent(reader.getItem());
            }
        });

        renderer.actions.put(Renderer.InAction.INSERT_ITEM_BEFORE, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().insertBefore(reader.getItem());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_VISIBLE, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setVisible(reader.getBoolean());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_CLIP, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setClip(reader.getBoolean());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_WIDTH, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setWidth(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_HEIGHT, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setHeight(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_X, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setX(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_Y, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setY(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_Z, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setZ(reader.getInteger());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_SCALE, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setScale(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_ROTATION, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setRotation(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_OPACITY, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setOpacity(reader.getInteger());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_BACKGROUND, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setBackground(reader.getItem());
            }
        });
    }

    public Item(Renderer renderer){
        this.renderer = renderer;
        this.id = renderer.items.size();
        renderer.items.add(this);

        childrenByZIndex = new ArrayList<>();
    }

    static int parseRGBA(String val){
        final long color = Long.parseLong(val, 16);
        return (int) (
            ((color & 0x000000FF) << 24) | //AA______
            ((color & 0xFFFFFF00) >>  8)); //__RRGGBB
    }

    public void setParent(Item val){
        if (parent != null){
            parent.childrenByZIndex.remove(this);

            if (zIndex != 0 && --parent.childrenWithZIndex > 0){
                parent.children.remove(this);
            }
        }

        if (val != null){
            val.childrenByZIndex.add(this);

            if (zIndex != 0){
                if (val.childrenWithZIndex++ == 0){
                    val.createChildrenArray();
                } else {
                    val.children.add(this);
                }
            }

            val.sortChildrenByZIndex();
        }

        this.parent = val;
    }

    public void insertBefore(Item val){
        // remove item from current parent
        setParent(null);

        // insert
        if (zIndex != 0){
            if (val.parent.childrenWithZIndex++ == 0){
                val.parent.createChildrenArray();
            } else {
                val.parent.children.set(val.parent.children.indexOf(val), this);
            }
        }

        if (val.parent.childrenWithZIndex > 0){
            val.parent.childrenByZIndex.add(this);
            val.parent.sortChildrenByZIndex();
        } else {
            val.parent.childrenByZIndex.set(val.parent.childrenByZIndex.indexOf(val), this);
        }
    }

    public void setVisible(boolean val){
        visible = val;
    }

    public void setClip(boolean val){
        clip = val;
    }

    public void setWidth(float val){
        width = renderer.dpToPx(val);
    }

    public void setHeight(float val){
        height = renderer.dpToPx(val);
    }

    public void setX(float val){
        x = renderer.dpToPx(val);
    }

    public void setY(float val){
        y = renderer.dpToPx(val);
    }

    public void setZ(int val){
        zIndex = val;
        if (val != 0){
            if (parent.childrenWithZIndex++ == 0) {
                parent.createChildrenArray();
            }
        } else {
            parent.childrenWithZIndex--;
        }

        parent.sortChildrenByZIndex();
    }

    public void setScale(float val){
        scale = val;
    }

    public void setRotation(float val){
        rotation = val * 180 / PI;
    }

    public void setOpacity(int val){
        opacity = val;
    }

    public void setBackground(Item val){
        background = val;
    }

    private void createChildrenArray(){
        if (children == null){
            children = new ArrayList<>();
        }
        children.clear();
        children.addAll(childrenByZIndex);
    }

    public void sortChildrenByZIndex(){
        if (childrenWithZIndex > 0) {
            Collections.sort(childrenByZIndex, zIndexComparator);
        }
    }

    protected void drawShape(Canvas canvas, int alpha){

    }

    protected void draw(Canvas canvas, int alpha) {
        if (opacity < 255) {
            alpha = Math.round(alpha * (opacity / 255f));
        }

        canvas.save();

        // translate to position
        canvas.translate(x, y);

        if (scale != 1 || rotation != 0) {
            final float originX = width / 2;
            final float originY = height / 2;

            // translate to origin
            canvas.translate(originX, originY);

            // scale
            canvas.scale(scale, scale);

            // rotation
            canvas.rotate(rotation);

            // translate to position
            canvas.translate(-originX, -originY);
        }

        // opacity

        // clip
        if (clip){
            canvas.clipRect(0, 0, width, height);
        }

        // background
        if (background != null){
            background.draw(canvas, alpha);
        }

        // shape
        drawShape(canvas, alpha);

        // render children
        for (Item child : childrenByZIndex){
            if (child.visible) {
                child.draw(canvas, alpha);
            }
        }

        canvas.restore();
    }
}
