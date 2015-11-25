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

        renderer.actions.put(Renderer.InAction.SET_ITEM_INDEX, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().setIndex(reader.getInteger());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_VISIBLE, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().visible = reader.getBoolean();
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_CLIP, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().clip = reader.getBoolean();
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_WIDTH, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().width = reader.getFloat() * reader.renderer.device.pixelRatio;
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_HEIGHT, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().height = reader.getFloat() * reader.renderer.device.pixelRatio;
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_X, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().x = reader.getFloat() * reader.renderer.device.pixelRatio;
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_Y, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().y = reader.getFloat() * reader.renderer.device.pixelRatio;
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
                reader.getItem().scale = reader.getFloat();
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_ROTATION, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().rotation = reader.getFloat() * 180 / PI;
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_OPACITY, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().opacity = reader.getInteger();
            }
        });

        renderer.actions.put(Renderer.InAction.SET_ITEM_BACKGROUND, new Action() {
            @Override
            void work(Reader reader) {
                reader.getItem().background = reader.getItem();
            }
        });
    }

    public Item(Renderer renderer){
        this.renderer = renderer;
        this.id = renderer.items.size();
        renderer.items.add(this);

        childrenByZIndex = new ArrayList<>();
    }

    static int colorFromString(String val){
        Pattern rgb = Pattern.compile("rgb *\\( *([0-9.]+), *([0-9.]+), *([0-9.]+) *\\)");
        Pattern rgba = Pattern.compile("rgba *\\( *([0-9.]+), *([0-9.]+), *([0-9.]+), *([0-9.]+) *\\)");
        Pattern shortHex = Pattern.compile("^#[0-9a-f]{3}$");
        Matcher match;

        val = val.toLowerCase().trim();

        if (val == "transparent" || val == ""){
            return Color.argb(0, 0, 0, 0);
        } else if ((match = rgb.matcher(val)).matches()){
            return Color.rgb(Integer.valueOf(match.group(1)),
                    Integer.valueOf(match.group(2)),
                    Integer.valueOf(match.group(3)));
        } else if ((match = rgba.matcher(val)).matches()) {
            return Color.argb(Math.round(Float.valueOf(match.group(4)) * 255),
                    Integer.valueOf(match.group(1)),
                    Integer.valueOf(match.group(2)),
                    Integer.valueOf(match.group(3)));
        } else if (shortHex.matcher(val).matches()) {
            return Color.parseColor("#" + val.charAt(1) + val.charAt(1) +
                    val.charAt(2) + val.charAt(2) +
                    val.charAt(3) + val.charAt(3));
        } else {
            try {
                return Color.parseColor(val);
            } catch (IllegalArgumentException error){
                Log.e("Neft", "Unknown color '"+val+"'");
                return Color.BLUE;
            }
        }
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

        parent = val;
    }

    public void setIndex(int val){
        final ArrayList<Item> array = parent.childrenWithZIndex > 0 ? parent.children : parent.childrenByZIndex;
        array.remove(this);
        array.set(val, this);
        parent.sortChildrenByZIndex();
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

    private void createChildrenArray(){
        if (children == null){
            children = new ArrayList<>();
        }
        children.clear();
        children.addAll(childrenByZIndex);
    }

    public void sortChildrenByZIndex(){
        Collections.sort(childrenByZIndex, zIndexComparator);
    }

    protected void drawShape(Canvas canvas, int alpha){

    }

    protected void draw(Canvas canvas, int alpha) {
        if (opacity < 255) {
            alpha *= opacity / 255;
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
