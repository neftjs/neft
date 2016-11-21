package io.neft.renderer;

import android.view.View;
import android.view.ViewTreeObserver;

import java.util.ArrayList;

import io.neft.App;
import io.neft.client.Reader;
import io.neft.MainActivity;
import io.neft.Native;

public class Renderer {

    public MainActivity app;
    final public ArrayList<Item> items;

    final public Device device = new Device();
    final public Screen screen = new Screen();
    final public Navigator navigator = new Navigator();

    public Renderer() {
        this.items = new ArrayList<>();

        items.add(null);

        View view = new View(App.getApp().getApplicationContext());
        App.getApp().view.addView(view);
        view.getViewTreeObserver().addOnPreDrawListener(new ViewTreeObserver.OnPreDrawListener() {
            @Override
            public boolean onPreDraw() {
                onAnimationFrame();
                return true;
            }
        });
    }

    public float pxToDp(float px) {
        return px / device.pixelRatio;
    }

    public float dpToPx(float dp) {
        return dp * device.pixelRatio;
    }

    public void pushItem(Item val) {
        app.client.pushInteger(val.id);
    }

    public void onAnimationFrame() {
        app.client.sendData();
        Native.renderer_callAnimationFrame();
    }

    public Item getItemFromReader(Reader reader) {
        return items.get(reader.getInteger());
    }

    public void init(MainActivity app) {
        Device.init(device, app);
        Screen.init(screen, app);
        Navigator.init(navigator, app);

        Navigator.register(app);
        Device.register(app);
        Screen.register(app);
    }
}
