package io.neft.extensions.slider_extension;

import android.widget.SeekBar;

import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCall;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

public class SliderItem extends NativeItem {
    private static final int DEFAULT_WIDTH = 150;
    private static final float PRECISION = 10000;
    private float minValue = 0;
    private float maxValue = 1;

    @OnCreate("Slider")
    public SliderItem() {
        super(new SeekBar(APP.getActivity().getApplicationContext()));
        pushWidth(Math.round(dpToPx(DEFAULT_WIDTH)));
        autoWidth = false;
        setMaxValue(maxValue);

        // fix clipping
        getItemView().setThumbOffset(8);

        getItemView().setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                pushEvent("valueChange", getValue());
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {}

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {}
        });
    }

    private SeekBar getItemView() {
        return (SeekBar) itemView;
    }

    public float getValue() {
        return getItemView().getProgress() / PRECISION;
    }

    @OnSet("value")
    public void setValue(float val) {
        getItemView().setProgress(Math.round(val * PRECISION));
    }

    @OnSet("minValue")
    public void setMinValue(float val) {
        minValue = val;
        setMaxValue(maxValue);
        if (getValue() < val) {
            setValue(val);
        }
    }

    @OnSet("maxValue")
    public void setMaxValue(float val) {
        maxValue = val;
        getItemView().setMax(Math.round(minValue + val * PRECISION));
    }

    @OnCall("setValueAnimated")
    public void setValueAnimated(float val) {
        setValue(val);
    }
}
