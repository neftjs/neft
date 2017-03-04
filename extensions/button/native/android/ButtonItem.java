package io.neft.extensions.buttonextension;

import android.graphics.Color;
import android.widget.Button;

import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;
import io.neft.utils.ColorValue;

public class ButtonItem extends NativeItem {
    @OnCreate("Button")
    public ButtonItem() {
        super(new Button(APP.getWindowView().getContext()));
        getItemView().setTextColor(Color.BLACK);
    }

    private Button getItemView() {
        return (Button) itemView;
    }

    @OnSet("text")
    public void setText(String val) {
        getItemView().setText(val);
        updateSize();
    }

    @OnSet("textColor")
    public void setTextColor(ColorValue val) {
        getItemView().setTextColor(val.getColor());
    }
}
