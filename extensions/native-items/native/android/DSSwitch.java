package io.neft.extensions.defaultstyles;

import android.widget.CompoundButton;
import android.widget.Switch;

import io.neft.App;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCall;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

public class DSSwitch extends NativeItem {
    @OnCreate("DSSwitchItem")
    public DSSwitch() {
        super(new Switch(App.getApp().getApplicationContext()));

        getItemView().setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                pushEvent("selectedChange", isChecked);
            }
        });
    }

    private Switch getItemView() {
        return (Switch) itemView;
    }

    @OnSet("selected")
    public void setSelected(boolean val) {
        getItemView().setChecked(val);
    }

    @OnCall("setSelectedAnimated")
    public void setSelectedAnimated(boolean val) {
        setSelected(val);
    }
}
