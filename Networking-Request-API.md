> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Request**

Request
=======

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#request)

METHODS
Contains available *HTTP* methods.
Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#array-requestmethods)

TYPES
Contains available expected types.
Contains:
 - Request.TEXT_TYPE,
 - Request.JSON_TYPE,
 - Request.HTML_TYPE,
 - Request.BINARY_TYPE.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#array-requesttypes)

Request
Class used to describe coming networking request.
You should use [Networking::createRequest()][networking/Networking::createRequest()]
to create a full request.
Access it with:
```javascript
var Networking = require('networking');
var Request = Networking.Request;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#request-requestobject-options)

onLoadEnd
> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#signal-requestonloadendany-error-any-data)

uid
Pseudo unique hash. It's created automatically.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-string-requestuid)

pending
Indicates whether the request is not destroyed.
If it's `false`, the request can't be changed.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-boolean-requestpending)

method
This property refers to one of the `Request.METHODS` values.
Holds a method with which the request has been called.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#string-requestmethod)

uri
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

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#networkinguri-requesturi)

type
Describes the expected response type.
It's used in the server-client communication.
In most cases, a server returns a HTML document for a crawler, but client
(which renders documents on his own side) expects a clean JSON response.
That's why, these two requests have the same uri, but different expected types.
It refers to one of the *Request.TYPES* values.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#string-requesttype)

data
Holds a data sent with a request.
It can be, for instance, a form data.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#object-requestdata--null)

handler
Refers to the currently considered [Handler][networking/Handler].

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-networkinghandler-requesthandler)

response
> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-networkingresponse-requestresponse)

params
Keeps matched parameters by the handler from the request uri.
Considering the */users/{name}* URI,
the 'name' property is available as the *params.name*.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-object-requestparams--)

headers
Contains request headers.
For the client request, this object is empty.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-object-requestheaders)

cookies
> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-object-requestcookies)

toString
Returns a string describing the request.
It contains a method, uri and a type.
```javascript
console.log(req.toString);
// get /users/id as json
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#string-requesttostring)

