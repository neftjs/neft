> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Response**

Response
========

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#response)

STATUSES
<dl><dt>Static property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
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

Response
<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Response</i></dd></dl>
Access it with:
```javascript
var Networking = require('networking');
var Response = Networking.Response;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#response-responseobject-options)

onSend
<dl><dt>Prototype method of</dt><dd><i>Response</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Called when the response has been sent.
```javascript
res.onSend(function(){
    console.log("Response has been sent!");
});
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#signal-responseonsend)

pending
<dl><dt>Prototype property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read only</dt></dl>
Indicates whether the response is not destroyed.

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#readonly-boolean-responsepending)

request
<dl><dt>Prototype property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>Networking.Request</i></dd><dt>Read only</dt></dl>
Refers to the [Request][networking/Request].

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#readonly-networkingrequest-responserequest)

status
<dl><dt>Prototype property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>Response.OK</code></dd></dl>
Keeps a normalized code determined the response type.
It refers to one of the *Response.STATUSES* values.
```javascript
res.status = Networking.Response.CREATED;
res.status = Networking.Response.PAYMENT_REQUIRED;
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#integer-responsestatus--responseok)

data
<dl><dt>Prototype property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
Value sent to the client.
```javascript
res.data = {items: ['superhero toy', 'book']};
res.data = new Error("Wrong order");
res.data = Document.fromJSON(...);
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#any-responsedata)

headers
<dl><dt>Prototype property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#object-responseheaders)

cookies
<dl><dt>Prototype property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#object-responsecookies)

encoding
<dl><dt>Prototype property of</dt><dd><i>Response</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'utf-8'</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#string-responseencoding--utf8)

setHeader
<dl><dt>Prototype method of</dt><dd><i>Response</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li><li>value — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Response</i></dd></dl>
```javascript
res.setHeader('Location', '/redirect/to/url');
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#response-responsesetheaderstring-name-string-value)

send
<dl><dt>Prototype method of</dt><dd><i>Response</i></dd><dt>Parameters</dt><dd><ul><li>status — <i>Integer</i> — <i>optional</i></li><li>data — <i>Any</i> — <i>optional</i></li></ul></dd></dl>
This method calls the [onSend()][networking/Response::onSend()] signal.
```javascript
res.onSend(function(){
    console.log("Response has been sent");
});
res.send(Networking.Response.OK, {user: 'Max', age: 43});
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#responsesendinteger-status-any-data)

redirect
<dl><dt>Prototype method of</dt><dd><i>Response</i></dd><dt>Parameters</dt><dd><ul><li>status — <i>Integer</i> — <code>= Response.FOUND</code></li><li>uri — <i>String</i></li></ul></dd></dl>
The *Response.FOUND* status is typically used for the temporary redirection.
The *Response.MOVED* for is a permanent redirection.

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#responseredirectinteger-status--responsefound-string-uri)

raise
<dl><dt>Prototype method of</dt><dd><i>Response</i></dd><dt>Parameters</dt><dd><ul><li>error — <i>Any</i></li></ul></dd></dl>
Finishes the response with an error.
```javascript
res.raise(new Networking.Response.Error("Login first"));
res.raise(new Networking.Response.Error(Networking.Response.UNAUTHORIZED, "Login first"));
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#responseraiseany-error)

isSucceed
<dl><dt>Prototype method of</dt><dd><i>Response</i></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the response status is in range from 200 to 299.

> [`Source`](/Neft-io/neft/tree/master/src/networking/response.litcoffee#boolean-responseissucceed)

