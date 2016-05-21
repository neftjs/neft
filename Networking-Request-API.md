> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Request**

Request
=======

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#request)

## Table of contents
* [Request](#request)
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
    * [params](#params)
    * [headers](#headers)
    * [cookies](#cookies)
    * [toString](#tostring)

METHODS
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Request.METHODS</code></dd><dt>Static property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
Contains available *HTTP* methods.
Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#array-requestmethods)

TYPES
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Request.TYPES</code></dd><dt>Static property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
Contains available expected types.
Contains:
 - Request.TEXT_TYPE,
 - Request.JSON_TYPE,
 - Request.HTML_TYPE,
 - Request.BINARY_TYPE.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#array-requesttypes)

Request
<dl><dt>Syntax</dt><dd><code>&#x2A;Request&#x2A; Request(&#x2A;Object&#x2A; options)</code></dd><dt>Parameters</dt><dd><ul><li>options — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></li></ul></dd><dt>Returns</dt><dd><i>Request</i></dd></dl>
Class used to describe coming networking request.
You should use [Networking::createRequest()][networking/Networking::createRequest()]
to create a full request.
Access it with:
```javascript
var Networking = require('networking');
var Request = Networking.Request;
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#request-requestobject-options)

onLoadEnd
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Request::onLoadEnd(&#x2A;Any&#x2A; error, &#x2A;Any&#x2A; data)</code></dd><dt>Prototype method of</dt><dd><i>Request</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Any</i></li><li>data — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#signal-requestonloadendany-error-any-data)

uid
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Request::uid</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
Pseudo unique hash. It's created automatically.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#readonly-string-requestuid)

pending
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Request::pending</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
Indicates whether the request is not destroyed.
If it's `false`, the request can't be changed.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#readonly-boolean-requestpending)

method
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Request::method</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
This property refers to one of the `Request.METHODS` values.
Holds a method with which the request has been called.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#string-requestmethod)

uri
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Uri&#x2A; Request::uri</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#networkinguri-requesturi)

type
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Request::type</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
Describes the expected response type.
It's used in the server-client communication.
In most cases, a server returns a HTML document for a crawler, but client
(which renders documents on his own side) expects a clean JSON response.
That's why, these two requests have the same uri, but different expected types.
It refers to one of the *Request.TYPES* values.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#string-requesttype)

data
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Request::data = null</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></dd><dt>Default</dt><dd><code>null</code></dd></dl>
Holds a data sent with a request.
It can be, for instance, a form data.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#object-requestdata--null)

handler
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Networking.Handler&#x2A; Request::handler</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Networking.Handler</i></dd><dt>Read only</dt></dl>
Refers to the currently considered [Handler][networking/Handler].

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#readonly-networkinghandler-requesthandler)

response
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Networking.Response&#x2A; Request::response</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Networking.Response</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#readonly-networkingresponse-requestresponse)

params
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Object&#x2A; Request::params = {}</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></dd><dt>Default</dt><dd><code>{}</code></dd><dt>Read only</dt></dl>
Keeps matched parameters by the handler from the request uri.
Considering the */users/{name}* URI,
the 'name' property is available as the *params.name*.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#readonly-object-requestparams--)

headers
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Object&#x2A; Request::headers</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></dd><dt>Read only</dt></dl>
Contains request headers.
For the client request, this object is empty.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#readonly-object-requestheaders)

cookies
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Object&#x2A; Request::cookies</code></dd><dt>Prototype property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#readonly-object-requestcookies)

toString
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Request::toString()</code></dd><dt>Prototype method of</dt><dd><i>Request</i></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Returns a string describing the request.
It contains a method, uri and a type.
```javascript
console.log(req.toString);
// get /users/id as json
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/request.litcoffee#string-requesttostring)

