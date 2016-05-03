Networking @engine
==================

This module cares about communication client-server and client internally.

Currently only the HTTP protocol is supported.

Access it with:
```javascript
var Networking = require('networking');
```

*Networking* Networking(*Object* options)
-----------------------------------------

*Signal* Networking::onRequest(*Networking.Request* request, *Networking.Response* response)
--------------------------------------------------------------------------------------------

ReadOnly *String* Networking::protocol
--------------------------------------

ReadOnly *Integer* Networking::port
-----------------------------------

ReadOnly *String* Networking::host
----------------------------------

ReadOnly *String* Networking::url
---------------------------------

URL path contains a protocol, port and a host.

It can be set manually if the external address is different.
Otherwise it's created automatically.

ReadOnly *String* Networking::language
--------------------------------------

Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').

ReadOnly *List* Networking::pendingRequests
-------------------------------------------

*Networking.Handler* Networking::createHandler(*Object* options)
----------------------------------------------------------------

Use this method to create a new [Handler][networking/Handler].

```javscript
app.networking.createHandler({
});
```

*Networking.Request* Networking::createRequest(*Object|Networking.Request* options)
-----------------------------------------------------------------------------------

The given options object corresponds to the [Request][networking/Request] properties.

*Networking.Request* Networking::get(*String* uri, *Function* onLoadEnd)
------------------------------------------------------------------------

*Networking.Request* Networking::post(*String* uri, [*Any* data], *Function* onLoadEnd)
---------------------------------------------------------------------------------------

*Networking.Request* Networking::put(*String* uri, [*Any* data], *Function* onLoadEnd)
--------------------------------------------------------------------------------------

*Networking.Request* Networking::delete(*String* uri, [*Any* data], *Function* onLoadEnd)
-----------------------------------------------------------------------------------------

Networking::resolveRequest(*Networking.Request* request)
----------------------------------------------------------------------------------------

*Networking.Request* Networking::createLocalRequest(*Object|Networking.Request* options)
----------------------------------------------------------------------------------------

Use this method to create a new [Request][networking/Request] and handle it.

The given options object corresponds to the [Request][networking/Request] properties.

Local and server requests are supported.

### Local requests

```javascript
app.networking.createRequest({
});
```

### Requests to the server

```javascript
app.networking.createRequest({
});
```

