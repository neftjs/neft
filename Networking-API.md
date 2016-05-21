> [Wiki](Home) ▸ [API Reference](API-Reference)

Networking
<dl><dt>Syntax</dt><dd>Networking @engine</dd></dl>
This module cares about communication client-server and client internally.
Currently only the HTTP protocol is supported.
Access it with:
```javascript
var Networking = require('networking');
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-engine)

Networking
<dl><dt>Syntax</dt><dd>*Networking* Networking([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options)</dd><dt>Parameters</dt><dd><ul><li>options — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Networking</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-networkingobject-options)

onRequest
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Networking::onRequest(*Networking.Request* request, *Networking.Response* response)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>request — <i>Networking.Request</i></li><li>response — <i>Networking.Response</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#signal-networkingonrequestnetworkingrequest-request-networkingresponse-response)

protocol
<dl><dt>Syntax</dt><dd>ReadOnly *String* Networking::protocol</dd><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingprotocol)

port
<dl><dt>Syntax</dt><dd>ReadOnly [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Networking::port</dd><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-integer-networkingport)

host
<dl><dt>Syntax</dt><dd>ReadOnly *String* Networking::host</dd><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinghost)

url
<dl><dt>Syntax</dt><dd>ReadOnly *String* Networking::url</dd><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
URL path contains a protocol, port and a host.
It can be set manually if the external address is different.
Otherwise it's created automatically.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingurl)

language
<dl><dt>Syntax</dt><dd>ReadOnly *String* Networking::language</dd><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinglanguage)

pendingRequests
<dl><dt>Syntax</dt><dd>ReadOnly [*List*](/Neft-io/neft/wiki/List-API.md#class-list) Networking::pendingRequests</dd><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>List</i></dd><dt>Read only</dt></dl>
Use this method to create a new [Handler][networking/Handler].
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

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-list-networkingpendingrequestsnetworkinghandler-networkingcreatehandlerobject-options)

createRequest
<dl><dt>Syntax</dt><dd>*Networking.Request* Networking::createRequest(*Object|Networking.Request* options)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object or Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
The given options object corresponds to the [Request][networking/Request] properties.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingcreaterequestobjectnetworkingrequest-options)

get
<dl><dt>Syntax</dt><dd>*Networking.Request* Networking::get(*String* uri, *Function* onLoadEnd)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkinggetstring-uri-function-onloadend)

post
<dl><dt>Syntax</dt><dd>*Networking.Request* Networking::post(*String* uri, [*Any* data], *Function* onLoadEnd)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingpoststring-uri-any-data-function-onloadend)

put
<dl><dt>Syntax</dt><dd>*Networking.Request* Networking::put(*String* uri, [*Any* data], *Function* onLoadEnd)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingputstring-uri-any-data-function-onloadend)

delete
<dl><dt>Syntax</dt><dd>*Networking.Request* Networking::delete(*String* uri, [*Any* data], *Function* onLoadEnd)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingdeletestring-uri-any-data-function-onloadend)

resolveRequest
<dl><dt>Syntax</dt><dd>Networking::resolveRequest(*Networking.Request* request)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>request — <i>Networking.Request</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingresolverequestnetworkingrequest-request)

createLocalRequest
<dl><dt>Syntax</dt><dd>*Networking.Request* Networking::createLocalRequest(*Object|Networking.Request* options)</dd><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object or Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#requests-to-the-server)

