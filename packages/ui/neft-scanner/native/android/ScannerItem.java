package io.neft.extensions.scanner_extension;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.util.SparseArray;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import com.google.android.gms.vision.CameraSource;
import com.google.android.gms.vision.Detector;
import com.google.android.gms.vision.barcode.Barcode;
import com.google.android.gms.vision.barcode.BarcodeDetector;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import io.neft.App;
import io.neft.renderer.Item;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;

public class ScannerItem extends NativeItem {
    private static App APP = Item.APP;
    private Set<String> tempDiscovery = new HashSet<>();
    private Set<String> lastDiscovery = new HashSet<>();
    private Set<String> newDiscovery = new HashSet<>();
    private SurfaceView surfaceView;
    private BarcodeDetector barcodeDetector;
    private CameraSource cameraSource;
    private boolean attached = false;
    private boolean ready = false;
    private boolean started = false;

    @OnCreate("Scanner")
    public ScannerItem() {
        super(new SurfaceView(APP.getActivity().getApplicationContext()));

        Context context = APP.getActivity().getApplicationContext();

        this.surfaceView = (SurfaceView) itemView;
        view.setClipChildren(true);

        this.barcodeDetector = new BarcodeDetector.Builder(context)
                .setBarcodeFormats(Barcode.ALL_FORMATS)
                .build();

        this.cameraSource = new CameraSource.Builder(context, barcodeDetector)
                .setAutoFocusEnabled(true)
                .build();

        surfaceView.getHolder().addCallback(new SurfaceHolder.Callback() {
            @Override
            public void surfaceCreated(SurfaceHolder holder) {
                APP.getPermissions().whenGranted(Manifest.permission.CAMERA, new Runnable() {
                    @Override
                    public void run() {
                        ready = true;
                        startCamera();
                    }
                });
            }

            @Override
            public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
                startCamera();
            }

            @Override
            public void surfaceDestroyed(SurfaceHolder holder) {
                ready = false;
                stopCamera();
            }
        });

        barcodeDetector.setProcessor(new Detector.Processor<Barcode>() {
            @Override
            public void release() {}

            @Override
            public void receiveDetections(Detector.Detections<Barcode> detections) {
                SparseArray<Barcode> barcodes = detections.getDetectedItems();
                int size = barcodes.size();
                for (int i = 0; i < size; i++) {
                    Barcode barcode = barcodes.valueAt(i);
                    if (barcode != null) {
                        newDiscovery.add(barcode.rawValue);
                    }
                }

                if (newDiscovery.size() > 0) {
                    for (String discovery : lastDiscovery) {
                        if (newDiscovery.contains(discovery)) {
                            tempDiscovery.add(discovery);
                        }
                    }
                    lastDiscovery.clear();
                    lastDiscovery.addAll(tempDiscovery);
                    tempDiscovery.clear();

                    for (String discovery : newDiscovery) {
                        if (!lastDiscovery.contains(discovery)) {
                            lastDiscovery.add(discovery);
                            pushEvent("scanned", discovery);
                        }
                    }

                    newDiscovery.clear();
                }
            }
        });
    }

    @SuppressLint("MissingPermission")
    private void startCamera() {
        if (!ready || !attached) return;
        if (started) {
            stopCamera();
        }
        started = true;
        try {
            cameraSource.start(surfaceView.getHolder());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void stopCamera() {
        started = false;
        cameraSource.stop();
    }

    @Override
    protected void onAttached() {
        attached = true;
        stopCamera();
    }

    @Override
    protected void onDetached() {
        attached = false;
        stopCamera();
    }
}
