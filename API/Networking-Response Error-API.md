> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Networking|Networking-API]] ▸ [[Response|Networking-Response-API]] ▸ **Response Error**

Response Error
==============

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/response/error.litcoffee#response-error)

## Table of contents
* [Response Error](#response-error)
    * [Error](#error)
    * [RequestResolve](#requestresolve)

Error
<dl><dt>Syntax</dt><dd><code>&#x2A;Error&#x2A; Error([&#x2A;Integer&#x2A; status, &#x2A;String&#x2A; message])</code></dd><dt>Parameters</dt><dd><ul><li>status — <a href="/Neft-io/neft/Utils-API.md#isinteger">Integer</a> — <i>optional</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Error</i></dd></dl>
It works as a standard Javascript *Error* class, but provides an extra *status* value.

Access it with:
```javascript
var Networking = require('networking');
var ResponseError = Networking.Response.Error;
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/response/error.litcoffee#error)

RequestResolve
<dl><dt>Syntax</dt><dd><code>&#x2A;RequestResolve&#x2A; Error.RequestResolve(&#x2A;Networking.Request&#x2A; request)</code></dd><dt>Static method of</dt><dd><i>Error</i></dd><dt>Parameters</dt><dd><ul><li>request — <a href="/Neft-io/neft/Networking-Request-API.md#class-request">Networking.Request</a></li></ul></dd><dt>Returns</dt><dd><i>RequestResolve</i></dd></dl>
This error is sent if the request can't be resolved,
because no proper handler which can handle the request can be found.

Access it with:
```javascript
var Networking = require('networking');
var RequestResolveResponseError = Networking.Response.Error.RequestResolve;
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/response/error.litcoffee#requestresolve)

