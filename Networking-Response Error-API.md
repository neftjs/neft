> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Response Error**

Response Error
==============

> [`Source`](/Neft-io/neft/tree/master/src/networking/response/error.litcoffee#response-error)

## Table of contents
* [Response Error](#response-error)
    * [Error](#error)
    * [RequestResolve](#requestresolve)

Error
<dl><dt>Syntax</dt><dd>*Error* Error([[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) status, *String* message])</dd><dt>Parameters</dt><dd><ul><li>status — <i>Integer</i> — <i>optional</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Error</i></dd></dl>
It works as a standard Javascript *Error* class, but provides an extra *status* value.
Access it with:
```javascript
var Networking = require('networking');
var ResponseError = Networking.Response.Error;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response/error.litcoffee#error-errorinteger-status-string-message)

RequestResolve
<dl><dt>Syntax</dt><dd>*RequestResolve* Error.RequestResolve(*Networking.Request* request)</dd><dt>Static method of</dt><dd><i>Error</i></dd><dt>Parameters</dt><dd><ul><li>request — <i>Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><i>RequestResolve</i></dd></dl>
This error is sent if the request can't be resolved,
because no proper handler which can handle the request can be found.
Access it with:
```javascript
var Networking = require('networking');
var RequestResolveResponseError = Networking.Response.Error.RequestResolve;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response/error.litcoffee#requestresolve-errorrequestresolvenetworkingrequest-request)

