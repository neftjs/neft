package io.neft.extensions.defaultstyles;

import android.graphics.Color;
import android.widget.Button;

import io.neft.App;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;
import io.neft.utils.ColorValue;

public class DSButton extends NativeItem {
    @OnCreate("DSButtonItem")
    public DSButton() {
        super(new Button(App.getApp().getApplicationContext()));
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
