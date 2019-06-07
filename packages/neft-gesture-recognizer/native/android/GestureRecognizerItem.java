package io.neft.extensions.gesturerecognizer_extension;

import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.View;
import io.neft.renderer.ItemView;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCall;
import io.neft.renderer.annotation.OnCreate;

public class GestureRecognizerItem extends NativeItem {
    @OnCreate("GestureRecognizer")
    public GestureRecognizerItem() {
        super(new ItemView(APP.getActivity().getApplicationContext()));
    }

    @OnCall("startRecognizingPinch")
    public void startRecognizingPinch() {
        final ScaleGestureDetector detector = new ScaleGestureDetector(APP.getActivity().getApplicationContext(), new ScaleGestureDetector.OnScaleGestureListener() {
            @Override
            public boolean onScale(ScaleGestureDetector scaleGestureDetector) {
                float focusX = pxToDp(scaleGestureDetector.getFocusX());
                float focusY = pxToDp(scaleGestureDetector.getFocusY());
                float scale = scaleGestureDetector.getScaleFactor();
                pushEvent("pinch", focusX, focusY, scale);
                return true;
            }

            @Override
            public boolean onScaleBegin(ScaleGestureDetector scaleGestureDetector) {
                return true;
            }

            @Override
            public void onScaleEnd(ScaleGestureDetector scaleGestureDetector) {

            }
        });

        itemView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (pressed) {
                    detector.onTouchEvent(event);
                }
                return true;
            }
        });
    }
}
