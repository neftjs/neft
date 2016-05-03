Handler
=======

*Handler* Handler(*Object* options)
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

*String* Handler::method
------------------------

Describes which type of the request, this handler can handle.

*Networking.Uri* Handler::uri
-----------------------------

This property is compared with the request uri.

*Schema* Handler::schema = null
-------------------------------

Used to determine whether the request uri is valid and can be handled by the handler callback.

*Function* Handler::callback
----------------------------

Function used to handle the request.

It's called with three parameters: **Networking.Request**, **Networking.Response** and
a *next* function.

If the *next* function is called, the next handler is checked.

Handler::exec(*Networking.Request* request, *Networking.Response* response, *Function* next)
--------------------------------------------------------------------------------------------

Executes the handler, that is:
 - compares the uri with the request,
 - validates the request uri with the schema,
 - calls the handler callback.

It's internally called by the [createRequest()][networking/Networking::createRequest()].

*String* Handler::toString()
----------------------------

Returns a string describing the handler.

```javascript
"get /users/{name}"
```

