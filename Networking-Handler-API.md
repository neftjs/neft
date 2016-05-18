> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Handler**

Handler
=======

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#handler)

## Table of contents
  * [Handler(options)](#handler-handlerobject-options)
  * [method](#string-handlermethod)
  * [*Networking.Uri* uri](#networkinguri-handleruri)
  * [schema = null](#schema-handlerschema--null)
  * [callback](#function-handlercallback)
  * [exec(*Networking.Request* request, *Networking.Response* response, next)](#handlerexecnetworkingrequest-request-networkingresponse-response-function-next)
  * [toString()](#string-handlertostring)

*Handler* Handler([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options)
-----------------------------------

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

*String* Handler::method
------------------------

Describes which type of the request, this handler can handle.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#string-handlermethod)

*Networking.Uri* Handler::uri
-----------------------------

This property is compared with the request uri.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#networkinguri-handleruri)

*Schema* Handler::schema = null
-------------------------------

Used to determine whether the request uri is valid and can be handled by the handler callback.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#schema-handlerschema--null)

*Function* Handler::callback
----------------------------

Function used to handle the request.
It's called with three parameters: **Networking.Request**, **Networking.Response** and
a *next* function.
If the *next* function is called, the next handler is checked.

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#function-handlercallback)

Handler::exec(*Networking.Request* request, *Networking.Response* response, *Function* next)
--------------------------------------------------------------------------------------------

Executes the handler, that is:
 - compares the uri with the request,
 - validates the request uri with the schema,
 - calls the handler callback.
It's internally called by the [createRequest()][networking/Networking::createRequest()].

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#handlerexecnetworkingrequest-request-networkingresponse-response-function-next)

*String* Handler::toString()
----------------------------

Returns a string describing the handler.
```javascript
"get /users/{name}"
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/handler.litcoffee#string-handlertostring)

