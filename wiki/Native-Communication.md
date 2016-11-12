Custom communication with the native code is available by the `native` module. Such communication is always asynchronous.

```javascript
var native = require('native');

native.callFunction('functionName', arg1, arg2, ...);
native.on('nativeEventName', function(arg1, arg2, ...){});
```

You can call native function using `native.callFunction()` and listen on getting native event by registering a listener using the `native.on()` method.

Native communication right now supports only: nulls, booleans, floats and strings, but still you can operate on renderer items using their number IDs.

Native code must be placed in folder `/native` created in you application. 
You will find there a sample code with function registering and event sending.
