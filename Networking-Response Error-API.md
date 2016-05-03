Response Error
==============

*Error* Error([*Integer* status, *String* message])
---------------------------------------------------

It works as a standard Javascript *Error* class, but provides an extra *status* value.

Access it with:
```javascript
var Networking = require('networking');
var ResponseError = Networking.Response.Error;
```

*RequestResolve* Error.RequestResolve(*Networking.Request* request)
-------------------------------------------------------------------

This error is sent if the request can't be resolved,
because no proper handler which can handle the request can be found.

Access it with:
```javascript
var Networking = require('networking');
var RequestResolveResponseError = Networking.Response.Error.RequestResolve;
```

