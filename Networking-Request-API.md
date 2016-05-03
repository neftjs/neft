Request
=======

*Array* Request.METHODS
-----------------------

Contains available *HTTP* methods.

Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS.

*Array* Request.TYPES
---------------------

Contains available expected types.

Contains:
 - Request.TEXT_TYPE,
 - Request.JSON_TYPE,
 - Request.HTML_TYPE,
 - Request.BINARY_TYPE.

*Request* Request(*Object* options)
-----------------------------------

Class used to describe coming networking request.

You should use [Networking::createRequest()][networking/Networking::createRequest()]
to create a full request.

Access it with:
```javascript
var Networking = require('networking');
var Request = Networking.Request;
```

*Signal* Request::onLoadEnd(*Any* error, *Any* data)
----------------------------------------------------

ReadOnly *String* Request::uid
------------------------------

Pseudo unique hash. It's created automatically.

ReadOnly *Boolean* Request::pending
-----------------------------------

Indicates whether the request is not destroyed.

If it's `false`, the request can't be changed.

*String* Request::method
------------------------

This property refers to one of the `Request.METHODS` values.

Holds a method with which the request has been called.

*Networking.Uri* Request::uri
-----------------------------

Refers to the request URI path.

It can holds local and absolute paths.

```javascript
// for request sent to the server ...
"http://server.domain/auth/user"

// for got request on the server ...
"http://server.domain/auth/user"

// for local requests ...
"/user/user_id"
```

*String* Request::type
----------------------

Describes the expected response type.

It's used in the server-client communication.
In most cases, a server returns a HTML document for a crawler, but client
(which renders documents on his own side) expects a clean JSON response.
That's why, these two requests have the same uri, but different expected types.

It refers to one of the *Request.TYPES* values.

*Object* Request::data = null
-----------------------------

Holds a data sent with a request.
It can be, for instance, a form data.

ReadOnly *Networking.Handler* Request::handler
----------------------------------------------

Refers to the currently considered [Handler][networking/Handler].

ReadOnly *Networking.Response* Request::response
------------------------------------------------

ReadOnly *Object* Request::params = {}
--------------------------------------

Keeps matched parameters by the handler from the request uri.

Considering the */users/{name}* URI,
the 'name' property is available as the *params.name*.

ReadOnly *Object* Request::headers
----------------------------------

Contains request headers.

For the client request, this object is empty.

ReadOnly *Object* Request::cookies
----------------------------------

*String* Request::toString()
----------------------------

Returns a string describing the request.

It contains a method, uri and a type.

```javascript
console.log(req.toString);
// get /users/id as json
```

