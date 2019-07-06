package io.neft.extensions.firebasemessaging_extension;

import com.google.firebase.iid.FirebaseInstanceIdService;

public class FirebaseIDService extends FirebaseInstanceIdService {
    @Override
    public void onTokenRefresh() {
        FirebaseMessagingExtension.pushToken();
    }
}
