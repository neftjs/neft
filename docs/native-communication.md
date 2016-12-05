# Native Communication

It's not possible to support all different APIs on all supported platforms. Sometimes you need to code in native.

Each platform can use different programming language. For instance on Android you can use *Java* or *C*.

You cannot call native methods directly from JavaScript, but you can achieve such communication creating a **bridge**.

Neft provides a module called [native](/api/native.html).
Use it in your JavaScript code to send data and to receive it.

Native communication needs to be asynchronous and cannot block your execution.

In passing and receiving data you're limited to basic types:
 - `null`,
 - float number,
 - boolean,
 - string.

Passing complex structures like arrays or objects is not supported, but you can parse it to JSON and send as a string.

Let's check, how we can communicate on different platforms:

## JavaScript client

To send and receive native messages, use [native](/api/native.html) module.

```javascript
Neft.native.callFunction("functionName", "arg1", "arg2", "argMore...");
Neft.native.on("eventName", (arg1, arg2, arg3) -> {});
```

## iOS

Create a `native/ios/CustomApp.swift` file in your main application folder.

```swift
class CustomApp {
    init() {
        App.getApp().client.pushEvent("eventName", args: ["arg1", "arg2", CGFloat(2.4), nil])
        App.getApp().client.addCustomFunction("functionName") {
            (args: [Any?]) in ()
        }
    }
}
```

## Android

Create a `native/android/CustomApp.java` file in your main application folder.

```java
package io.neft.customapp;

import io.neft.Client.CustomFunction;

public class CustomApp {
    public CustomApp() {
        App.getApp().client.pushEvent("eventName", "arg1", "arg2", 2.4f, null);
        App.getApp().client.addCustomFunction("functionName", new CustomFunction() {
            @Override
            public void work(Object[] args) {}
        });
    }
}
```
