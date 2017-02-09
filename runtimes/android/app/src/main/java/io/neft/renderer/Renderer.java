package io.neft.renderer;

import java.util.ArrayList;
import java.util.List;

import io.neft.client.Reader;
import lombok.Getter;

public class Renderer {
    final private List<Item> items = new ArrayList<>();
    @Getter final private Device device = new Device();
    final private Screen screen = new Screen();
    final private Navigator navigator = new Navigator();

    public Renderer() {
        items.add(null);
    }

    public float pxToDp(float px) {
        return px / device.getPixelRatio();
    }

    public float dpToPx(float dp) {
        return dp * device.getPixelRatio();
    }

    synchronized int registerItem(Item item) {
        items.add(item);
        return items.size() - 1;
    }

    public Item getItemFromReader(Reader reader) {
        return getItemById(reader.getInteger());
    }

    public Item getItemById(int id) {
        return items.get(id);
    }

    public void init() {
        Device.init(device);
        Screen.init(screen);
        Navigator.init(navigator);
    }
}
