> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Response**

Response
========

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#response)

## Table of contents
  * [Response.STATUSES](#array-responsestatuses)
  * [Response(options)](#response-responseobject-options)
  * [onSend()](#signal-responseonsend)
  * [pending](#readonly-boolean-responsepending)
  * [*Networking.Request* request](#readonly-networkingrequest-responserequest)
  * [status = Response.OK](#integer-responsestatus--responseok)
  * [data](#any-responsedata)
  * [headers](#object-responseheaders)
  * [cookies](#object-responsecookies)
  * [encoding = 'utf-8'](#string-responseencoding--utf8)
  * [setHeader(name, value)](#response-responsesetheaderstring-name-string-value)
  * [send([status, data])](#responsesendinteger-status-any-data)
  * [redirect(status = `Response.FOUND`, uri)](#responseredirectinteger-status--responsefound-string-uri)
  * [raise(error)](#responseraiseany-error)
  * [isSucceed()](#boolean-responseissucceed)

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

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#array-responsestatuses)

*Response* Response(*Object* options)
-------------------------------------

Access it with:
```javascript
var Networking = require('networking');
var Response = Networking.Response;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#response-responseobject-options)

*Signal* Response::onSend()
---------------------------

Called when the response has been sent.
```javascript
res.onSend(function(){
    console.log("Response has been sent!");
});
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#signal-responseonsend)

ReadOnly *Boolean* Response::pending
------------------------------------

Indicates whether the response is not destroyed.

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#readonly-boolean-responsepending)

ReadOnly *Networking.Request* Response::request
-----------------------------------------------

Refers to the [Request][networking/Request].

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#readonly-networkingrequest-responserequest)

*Integer* Response::status = Response.OK
----------------------------------------

Keeps a normalized code determined the response type.
It refers to one of the *Response.STATUSES* values.
```javascript
res.status = Networking.Response.CREATED;
res.status = Networking.Response.PAYMENT_REQUIRED;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#integer-responsestatus--responseok)

*Any* Response::data
--------------------

Value sent to the client.
```javascript
res.data = {items: ['superhero toy', 'book']};
res.data = new Error("Wrong order");
res.data = Document.fromJSON(...);
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#any-responsedata)

*Object* Response::headers
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#object-responseheaders)

*Object* Response::cookies
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#object-responsecookies)

*String* Response::encoding = 'utf-8'
-------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#string-responseencoding--utf8)

*Response* Response::setHeader(*String* name, *String* value)
-------------------------------------------------------------

```javascript
res.setHeader('Location', '/redirect/to/url');
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#response-responsesetheaderstring-name-string-value)

Response::send([*Integer* status, *Any* data])
----------------------------------------------

This method calls the [onSend()][networking/Response::onSend()] signal.
```javascript
res.onSend(function(){
    console.log("Response has been sent");
});
res.send(Networking.Response.OK, {user: 'Max', age: 43});
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#responsesendinteger-status-any-data)

Response::redirect(*Integer* status = `Response.FOUND`, *String* uri)
---------------------------------------------------------------------

The *Response.FOUND* status is typically used for the temporary redirection.
The *Response.MOVED* for is a permanent redirection.

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#responseredirectinteger-status--responsefound-string-uri)

Response::raise(*Any* error)
----------------------------

Finishes the response with an error.
```javascript
res.raise(new Networking.Response.Error("Login first"));
res.raise(new Networking.Response.Error(Networking.Response.UNAUTHORIZED, "Login first"));
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#responseraiseany-error)

*Boolean* Response::isSucceed()
-------------------------------

Returns `true` if the response status is in range from 200 to 299.

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#boolean-responseissucceed)

