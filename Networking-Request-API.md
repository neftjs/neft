> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Request**

Request
=======

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#request)

<dl><dt>Static property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
METHODS
Contains available *HTTP* methods.
Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#array-requestmethods)

<dl><dt>Static property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
TYPES
Contains available expected types.
Contains:
 - Request.TEXT_TYPE,
 - Request.JSON_TYPE,
 - Request.HTML_TYPE,
 - Request.BINARY_TYPE.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#array-requesttypes)

<dl><dt>Parameters</dt><dd><ul><li><b>options</b> — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Request</i></dd></dl>
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

<dl><dt>Prototype method of</dt><dd><i>Request</i></dd><dt>Parameters</dt><dd><ul><li><b>error</b> — <i>Any</i></li><li><b>data</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onLoadEnd
> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#signal-requestonloadendany-error-any-data)

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>read only</dt></dl>
uid
Pseudo unique hash. It's created automatically.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-string-requestuid)

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>read only</dt></dl>
pending
Indicates whether the request is not destroyed.
If it's `false`, the request can't be changed.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-boolean-requestpending)

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
method
This property refers to one of the `Request.METHODS` values.
Holds a method with which the request has been called.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#string-requestmethod)

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>
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

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
type
Describes the expected response type.
It's used in the server-client communication.
In most cases, a server returns a HTML document for a crawler, but client
(which renders documents on his own side) expects a clean JSON response.
That's why, these two requests have the same uri, but different expected types.
It refers to one of the *Request.TYPES* values.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#string-requesttype)

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
data
Holds a data sent with a request.
It can be, for instance, a form data.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#object-requestdata--null)

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Networking.Handler</i></dd><dt>read only</dt></dl>
handler
Refers to the currently considered [Handler][networking/Handler].

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-networkinghandler-requesthandler)

<dl><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Networking.Response</i></dd><dt>read only</dt></dl>
response
> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-networkingresponse-requestresponse)

## Table of contents
    * [METHODS](#methods)
    * [TYPES](#types)
    * [Request](#request)
    * [onLoadEnd](#onloadend)
    * [uid](#uid)
    * [pending](#pending)
    * [method](#method)
    * [uri](#uri)
    * [type](#type)
    * [data](#data)
    * [handler](#handler)
    * [response](#response)
  * [ReadOnly *Object* Request::params = {}](#readonly-object-requestparams--)
  * [ReadOnly *Object* Request::headers](#readonly-object-requestheaders)
  * [ReadOnly *Object* Request::cookies](#readonly-object-requestcookies)
  * [*String* Request::toString()](#string-requesttostring)

ReadOnly [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Request::params = {}
--------------------------------------

Keeps matched parameters by the handler from the request uri.
Considering the */users/{name}* URI,
the 'name' property is available as the *params.name*.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-object-requestparams--)

ReadOnly [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Request::headers
----------------------------------

Contains request headers.
For the client request, this object is empty.

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-object-requestheaders)

ReadOnly [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Request::cookies
----------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#readonly-object-requestcookies)

*String* Request::toString()
----------------------------

Returns a string describing the request.
It contains a method, uri and a type.
```javascript
console.log(req.toString);
// get /users/id as json
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/request.litcoffee#string-requesttostring)

