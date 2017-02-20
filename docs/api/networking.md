# Networking

> **API Reference** ▸ **Networking**

<!-- toc -->
This module cares about communication client-server and client internally.

Currently only the HTTP protocol is supported.

Access it with:
```javascript
var Networking = require('networking');
```


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object</i></li></ul></dd></dl>

Options:
- `allowAllOrigins` determines whether *Access-Control-Allow-Origin* should return wildcard,
  false by default


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkingconstructorobject-options)


* * * 

### `onRequest()`

<dl><dt>Parameters</dt><dd><ul><li>request — <i>Networking.Request</i></li><li>response — <i>Networking.Response</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#signal-networkingonrequestnetworkingrequest-request-networkingresponse-response)


* * * 

### `protocol`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#readonly-string-networkingprotocol)


* * * 

### `port`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#readonly-integer-networkingport)


* * * 

### `host`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#readonly-string-networkinghost)


* * * 

### `url`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>

URL path contains a protocol, port and a host.

It can be set manually if the external address is different.
Otherwise it's created automatically.


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#readonly-string-networkingurl)


* * * 

### `language`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>

Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#readonly-string-networkinglanguage)


* * * 

### `pendingRequests`

<dl><dt>Type</dt><dd><i>List</i></dd><dt>Read Only</dt></dl>


* * * 

### `createHandler()`

<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Handler</i></dd></dl>

Use this method to create a new *Networking.Handler*.

```javscript
app.networking.createHandler({
    method: 'get',
    uri: '/users/{name}',
    schema: new Schema({
        name: {
            type: 'string',
            min: 3
        },
    }),
    callback: function(req, res, next){
        res.raise(new Networking.Response.Error(Networking.Response.NOT_IMPLEMENTED));
    }
});
```


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkinghandler-networkingcreatehandlerobject-options)


* * * 

### `createRequest()`

<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object|Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>

The given options object corresponds to the *Networking.Request* properties.


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkingrequest-networkingcreaterequestobjectnetworkingrequest-options)


* * * 

### `get()`

<dl><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkingrequest-networkinggetstring-uri-function-onloadend)


* * * 

### `post()`

<dl><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkingrequest-networkingpoststring-uri-any-data-function-onloadend)


* * * 

### `put()`

<dl><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkingrequest-networkingputstring-uri-any-data-function-onloadend)


* * * 

### `delete()`

<dl><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkingrequest-networkingdeletestring-uri-any-data-function-onloadend)


* * * 

### `resolveRequest()`

<dl><dt>Parameters</dt><dd><ul><li>request — <i>Networking.Request</i></li></ul></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee#networkingresolverequestnetworkingrequest-request)


* * * 

### `createLocalRequest()`

<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object|Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>

Use this method to create a new [Request][networking/Request] and handle it.

The given options object corresponds to the [Request][networking/Request] properties.

Local and server requests are supported.

### Local requests

```javascript
app.networking.createRequest({
    uri: '/achievements/world_2',
    onLoadEnd: function(err, data){
        if (this.response.isSucceed()){
            console.log("Request has been loaded! Data: " + data);
        } else {
            console.log("Error: " + err);
        }
    }
});
```

### Requests to the server

```javascript
app.networking.createRequest({
    method: 'post',
    uri: 'http://server.domain/comments',
    data: {message: 'Great article! Like it.'},
    onLoadEnd: function(err, data){
        if (this.response.isSucceed()){
            console.log("Comment has been added!");
        }
    }
});
```


> [`Source`](https://github.com/Neft-io/neft/blob/c3c6f8f8caea44afbf317808559fc53e08c2f316/src/networking/index.litcoffee)

