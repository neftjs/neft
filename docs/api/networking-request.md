# Request

> **API Reference** ▸ [Networking](/api/networking.md) ▸ **Request**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee)


* * * 

### `Request.METHODS`

<dl><dt>Static property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>

Contains available *HTTP* methods.

Contains:
 - Request.GET,
 - Request.POST,
 - Request.PUT,
 - Request.DELETE,
 - Request.OPTIONS.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#array-requestmethods)


* * * 

### `Request.TYPES`

<dl><dt>Static property of</dt><dd><i>Request</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>

Contains available expected types.

Contains:
 - Request.TEXT_TYPE,
 - Request.JSON_TYPE,
 - Request.HTML_TYPE,
 - Request.BINARY_TYPE.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#array-requesttypes)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object</i></li></ul></dd></dl>

Class used to describe coming networking request.

You should use `createRequest()` to create a full request.

Access it with:
```javascript
var Networking = require('networking');
var Request = Networking.Request;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#requestconstructorobject-options)


* * * 

### `onLoadEnd()`

<dl><dt>Parameters</dt><dd><ul><li>error — <i>Any</i></li><li>data — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#signal-requestonloadendany-error-any-data)


* * * 

### `uid`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>

Pseudo unique hash. It's created automatically.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#readonly-string-requestuid)


* * * 

### `pending`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>

Indicates whether the request is not destroyed.

If it's `false`, the request can't be changed.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#readonly-boolean-requestpending)


* * * 

### `method`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>

This property refers to one of the `Request.METHODS` values.

Holds a method with which the request has been called.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#string-requestmethod)


* * * 

### `uri`

<dl><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#networkinguri-requesturi)


* * * 

### `type`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>

Describes the expected response type.

It's used in the server-client communication.
In most cases, a server returns a HTML document for a crawler, but client
(which renders documents on his own side) expects a clean JSON response.
That's why, these two requests have the same uri, but different expected types.

It refers to one of the *Request.TYPES* values.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#string-requesttype)


* * * 

### `data`

<dl><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>

Holds a data sent with a request.
It can be, for instance, a form data.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#object-requestdata--null)


* * * 

### `handler`

<dl><dt>Type</dt><dd><i>Networking.Handler</i></dd><dt>Read Only</dt></dl>

Refers to the currently considered [Handler][networking/Handler].


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#readonly-networkinghandler-requesthandler)


* * * 

### `response`

<dl><dt>Type</dt><dd><i>Networking.Response</i></dd><dt>Read Only</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#readonly-networkingresponse-requestresponse)


* * * 

### `params`

<dl><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd><dt>Read Only</dt></dl>

Keeps matched parameters by the handler from the request uri.

Considering the */users/{name}* URI,
the 'name' property is available as the *params.name*.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#readonly-object-requestparams--)


* * * 

### `headers`

<dl><dt>Type</dt><dd><i>Object</i></dd><dt>Read Only</dt></dl>

Contains request headers.

For the client request, this object is empty.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#readonly-object-requestheaders)


* * * 

### `cookies`

<dl><dt>Type</dt><dd><i>Object</i></dd><dt>Read Only</dt></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#readonly-object-requestcookies)


* * * 

### `toString()`

<dl><dt>Returns</dt><dd><i>String</i></dd></dl>

Returns a string describing the request.

It contains a method, uri and a type.

```javascript
console.log(req.toString);
// get /users/id as json
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/request.litcoffee#string-requesttostring)

