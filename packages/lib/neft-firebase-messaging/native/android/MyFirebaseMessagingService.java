package io.neft.extensions.firebasemessaging_extension;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import org.json.JSONObject;

public class MyFirebaseMessagingService extends FirebaseMessagingService {
	@Override
	public void onMessageReceived(RemoteMessage remoteMessage) {
		JSONObject data = new JSONObject(remoteMessage.getData());
		FirebaseMessagingExtension.onMessageReceived(data);
	}
}
