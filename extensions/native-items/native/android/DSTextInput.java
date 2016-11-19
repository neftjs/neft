package io.neft.extensions.nativeitems;

import android.graphics.Color;
import android.text.Editable;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.TextWatcher;
import android.text.style.ForegroundColorSpan;
import android.widget.Button;
import android.widget.EditText;

import io.neft.App;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;
import io.neft.utils.ColorValue;

public class DSTextInput extends NativeItem {
    @OnCreate("DSTextInput")
    public DSTextInput() {
        super(new EditText(App.getApp().getApplicationContext()));

        setTextColor(new ColorValue(Color.BLACK));

        getItemView().addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                pushEvent("textChange", getItemView().getText().toString());
            }

            @Override
            public void afterTextChanged(Editable s) {}
        });
    }

    private EditText getItemView() {
        return (EditText) itemView;
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
