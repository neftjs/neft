# Neft Firebase Messaging

## Installation

Inside your Neft project type `npm install @neft/firebase-messaging` to install.

Created `google-services.json` file copy into `manifest/android/app` folder.

Created `GoogleService-Info.plist` file copy into `manifest/ios/app` folder.

## API

You can access the API by importing this extension.

```
const firebaseMessaging = require('neft-firebase-messaging')
```

### deviceToken

`firebaseMessaging.deviceToken` is a unique hash generated per each device.

In case of this hash refresh you need to listen a signal `firebaseMessaging.onDeviceTokenChange`.

### onMessageReceived

Received messages automatically generates a system notification only when your app is in background.

If your app is currently open by an user, the received message is accessible inside a `firebaseMessaging.onMessageReceived` signal.

```
const firebaseMessaging = require('neft-firebase-messaging')
firebaseMessaging.onMessageReceived.connect((event) => {
    console.log(`Title: ${event.title}`)
    console.log(`Body: ${event.body}`)
    console.log(`Data: ${JSON.stringify(event.data)}`)
})
```
