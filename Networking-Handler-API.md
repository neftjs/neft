> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Handler**

Handler
=======

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#handler)

<dl><dt>Parameters</dt><dd><ul><li><b>options</b> — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Handler</i></dd></dl>
Handler
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

<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
method
Describes which type of the request, this handler can handle.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#string-handlermethod)

<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>
uri
This property is compared with the request uri.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#networkinguri-handleruri)

<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>Schema</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
schema
Used to determine whether the request uri is valid and can be handled by the handler callback.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#schema-handlerschema--null)

<dl><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>Function</i></dd></dl>
callback
Function used to handle the request.
It's called with three parameters: **Networking.Request**, **Networking.Response** and
a *next* function.
If the *next* function is called, the next handler is checked.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#function-handlercallback)

<dl><dt>Prototype method of</dt><dd><i>Handler</i></dd><dt>Parameters</dt><dd><ul><li><b>request</b> — <i>Networking.Request</i></li><li><b>response</b> — <i>Networking.Response</i></li><li><b>next</b> — <i>Function</i></li></ul></dd></dl>
exec
Executes the handler, that is:
 - compares the uri with the request,
 - validates the request uri with the schema,
 - calls the handler callback.
It's internally called by the [createRequest()][networking/Networking::createRequest()].

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#handlerexecnetworkingrequest-request-networkingresponse-response-function-next)

## Table of contents
    * [Handler](#handler)
    * [method](#method)
    * [uri](#uri)
    * [schema](#schema)
    * [callback](#callback)
    * [exec](#exec)
  * [*String* Handler::toString()](#string-handlertostring)

*String* Handler::toString()
----------------------------

Returns a string describing the handler.
```javascript
"get /users/{name}"
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#string-handlertostring)

