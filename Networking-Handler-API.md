> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Handler**

Handler
=======

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#handler)

Handler
<dl><dt>Parameters</dt><dd><ul><li><b>options</b> — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Handler</i></dd></dl>
Represents a callback function called on the request.
Each handler must determine an uri, which is compared with the got request URI.
You should use [createHandler()][networking/Networking::createHandler()] to create
a functional handler.
Access it with:
```javascript
var Networking = require('networking');
var Handler = Networking.Handler;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#handler-handlerobject-options)

method
<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
Describes which type of the request, this handler can handle.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#string-handlermethod)

uri
<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>
This property is compared with the request uri.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#networkinguri-handleruri)

schema
<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>Schema</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
Used to determine whether the request uri is valid and can be handled by the handler callback.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#schema-handlerschema--null)

callback
<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>Function</i></dd></dl>
Function used to handle the request.
It's called with three parameters: **Networking.Request**, **Networking.Response** and
a *next* function.
If the *next* function is called, the next handler is checked.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#function-handlercallback)

exec
<dl><dt>Prototype method of</dt><dd><i>Handler</i></dd><dt>Parameters</dt><dd><ul><li><b>request</b> — <i>Networking.Request</i></li><li><b>response</b> — <i>Networking.Response</i></li><li><b>next</b> — <i>Function</i></li></ul></dd></dl>
Executes the handler, that is:
 - compares the uri with the request,
 - validates the request uri with the schema,
 - calls the handler callback.
It's internally called by the [createRequest()][networking/Networking::createRequest()].

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#handlerexecnetworkingrequest-request-networkingresponse-response-function-next)

toString
<dl><dt>Prototype method of</dt><dd><i>Handler</i></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Returns a string describing the handler.
```javascript
"get /users/{name}"
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#string-handlertostring)

