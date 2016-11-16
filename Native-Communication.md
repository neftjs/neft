Native communication needs to be asynchronous and supports sending nulls, booleans, floats or strings.

## JavaScript

To send and receive native messages, use [Neft.native](https://github.com/Neft-io/neft/wiki/Native-API) module.

```javascript
Neft.native.callFunction("functionName", "arg1", "arg2", "argMore");
Neft.native.on("eventName", (arg1, arg2, arg3) -> {});
```

Sending complex JavaScript structures are not supported. You can try to serialize them into *JSON*.

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