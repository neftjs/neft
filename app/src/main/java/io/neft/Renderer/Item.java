package io.neft.Renderer;

import android.graphics.Canvas;
import java.util.ArrayList;

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
    public final ArrayList<Item> children;

    private static final float PI = (float) Math.PI;

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

        children = new ArrayList<>();
    }

    static int parseRGBA(int val){
        return ((val & 0xFFFFFF00) >> 8) |  // __RRGGBB
                ((val & 0x000000FF) << 24); // AA______
    }

    public void setParent(Item val){
        if (parent != null){
            parent.children.remove(this);
        }

        if (val != null){
            val.children.add(this);
        }

        this.parent = val;
    }

    public void insertBefore(Item val){
        if (parent != null){
            parent.children.remove(this);
        }

        final Item parent = val.parent;
        final int index = parent.children.indexOf(val);
        parent.children.add(index, this);
        this.parent = parent;
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
        // TODO
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
        for (Item child : children){
            if (child.visible) {
                child.draw(canvas, alpha);
            }
        }

        canvas.restore();
    }
}
