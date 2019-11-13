package io.neft;

import android.app.Activity;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;
import android.util.SparseArray;

public class AppPermissions {
    private App app;
    private int lastUid = 0;
    private SparseArray<Runnable> requests = new SparseArray<>();

    AppPermissions(App app) {
        this.app = app;
    }

    private synchronized int produceUid() {
        int uid = lastUid;
        lastUid += 1;
        return uid;
    }

    void handleRequestPermissionsResult(int requestCode, boolean granted) {
        Runnable callback = requests.get(requestCode);
        requests.delete(requestCode);
        if (callback != null && granted) {
            callback.run();
        }
    }

    public void whenGranted(String permission, Runnable callback) {
        Activity activity = app.getActivity();
        if (ActivityCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED) {
            callback.run();
        } else {
            int uid = produceUid();
            requests.append(uid, callback);
            ActivityCompat.requestPermissions(activity, new String[] { permission }, uid);
        }
    }
}
