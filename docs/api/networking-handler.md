# Handler

> **API Reference** ▸ [Networking](/api/networking.md) ▸ **Handler**

<!-- toc -->
Represents a callback function called on the request.

Each handler must determine an uri, which is compared with the got request URI.

You should use `createHandler()` to create a functional handler.

Access it with:
```javascript
var Networking = require('networking');
var Handler = Networking.Handler;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object</i></li></ul></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee#handlerconstructorobject-options)


* * * 

### `method`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>

Describes which type of the request, this handler can handle.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee#string-handlermethod)


* * * 

### `uri`

<dl><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>

This property is compared with the request uri.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee#networkinguri-handleruri)


* * * 

### `schema`

<dl><dt>Type</dt><dd><i>Schema</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>

Used to determine whether the request uri is valid and can be handled by the handler callback.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee#schema-handlerschema--null)


* * * 

### `callback`

<dl><dt>Type</dt><dd><i>Function</i></dd></dl>

Function used to handle the request.

It's called with three parameters: *Networking.Request*, *Networking.Response* and
a *next* function.

If the *next* function is called, the next handler is checked.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee#function-handlercallback)


* * * 

### `exec()`

<dl><dt>Parameters</dt><dd><ul><li>request — <i>Networking.Request</i></li><li>response — <i>Networking.Response</i></li><li>next — <i>Function</i></li></ul></dd></dl>

Executes the handler, that is:
 - compares the uri with the request,
 - validates the request uri with the schema,
 - calls the handler callback.

It's internally called by the `createRequest()`.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee#handlerexecnetworkingrequest-request-networkingresponse-response-function-next)


* * * 

### `toString()`

<dl><dt>Returns</dt><dd><i>String</i></dd></dl>

Returns a string describing the handler.

```javascript
"get /users/{name}"
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/handler.litcoffee#string-handlertostring)

