Response
========

*Array* Response.STATUSES
-------------------------

Contains abstract codes used to describe the response type.

Each status corresponds to the HTTP numeral value.
Check [http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html]() for more.

Contains:
 - Response.OK,
 - Response.CREATED,
 - Response.ACCEPTED,
 - Response.NO_CONTENT,
 - Response.MOVED,
 - Response.FOUND,
 - Response.NOT_MODIFIED,
 - Response.TEMPORARY_REDIRECT,
 - Response.BAD_REQUEST,
 - Response.UNAUTHORIZED,
 - Response.PAYMENT_REQUIRED,
 - Response.FORBIDDEN,
 - Response.NOT_FOUND,
 - Response.CONFLICT,
 - Response.PRECONDITION_FAILED,
 - Response.UNSUPPORTED_MEDIA_TYPE,
 - Response.INTERNAL_SERVER_ERROR,
 - Response.NOT_IMPLEMENTED,
 - Response.SERVICE_UNAVAILABLE.

```javascript
console.log(Networking.Response.OK);
console.log(Networking.Response.BAD_REQUEST);
```

*Response* Response(*Object* options)
-------------------------------------

Access it with:
```javascript
var Networking = require('networking');
var Response = Networking.Response;
```

*Signal* Response::onSend()
---------------------------

Called when the response has been sent.

```javascript
res.onSend(function(){
});
```

ReadOnly *Boolean* Response::pending
------------------------------------

Indicates whether the response is not destroyed.

ReadOnly *Networking.Request* Response::request
-----------------------------------------------

Refers to the [Request][networking/Request].

*Integer* Response::status = Response.OK
----------------------------------------

Keeps a normalized code determined the response type.

It refers to one of the *Response.STATUSES* values.

```javascript
res.status = Networking.Response.CREATED;
res.status = Networking.Response.PAYMENT_REQUIRED;
```

*Any* Response::data
--------------------

Value sent to the client.

```javascript
res.data = {items: ['superhero toy', 'book']};
res.data = new Error("Wrong order");
res.data = Document.fromJSON(...);
```

*Object* Response::headers
--------------------------

*Object* Response::cookies
--------------------------

*String* Response::encoding = 'utf-8'
-------------------------------------

*Response* Response::setHeader(*String* name, *String* value)
-------------------------------------------------------------

```javascript
res.setHeader('Location', '/redirect/to/url');
```

Response::send([*Integer* status, *Any* data])
----------------------------------------------

This method calls the [onSend()][networking/Response::onSend()] signal.

```javascript
res.onSend(function(){
});

res.send(Networking.Response.OK, {user: 'Max', age: 43});
```

Response::redirect(*Integer* status = `Response.FOUND`, *String* uri)
---------------------------------------------------------------------

The *Response.FOUND* status is typically used for the temporary redirection.
The *Response.MOVED* for is a permanent redirection.

Response::raise(*Any* error)
----------------------------

Finishes the response with an error.

```javascript
res.raise(new Networking.Response.Error("Login first"));
res.raise(new Networking.Response.Error(Networking.Response.UNAUTHORIZED, "Login first"));
```

*Boolean* Response::isSucceed()
-------------------------------

Returns `true` if the response status is in range from 200 to 299.

