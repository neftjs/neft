> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Networking
This module cares about communication client-server and client internally.
Currently only the HTTP protocol is supported.
Access it with:
```javascript
var Networking = require('networking');
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-engine)

<dl><dt>Parameters</dt><dd><ul><li><b>options</b> — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Networking</i></dd></dl>
Networking
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-networkingobject-options)

<dl><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li><b>request</b> — <i>Networking.Request</i></li><li><b>response</b> — <i>Networking.Response</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onRequest
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#signal-networkingonrequestnetworkingrequest-request-networkingresponse-response)

<dl><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>read only</dt></dl>
protocol
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingprotocol)

<dl><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>read only</dt></dl>
port
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-integer-networkingport)

<dl><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>read only</dt></dl>
host
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinghost)

<dl><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>read only</dt></dl>
url
URL path contains a protocol, port and a host.
It can be set manually if the external address is different.
Otherwise it's created automatically.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingurl)

<dl><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>read only</dt></dl>
language
Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinglanguage)

<dl><dt>Prototype property of</dt><dd><i>Networking</i></dd><dt>Type</dt><dd><i>List</i></dd><dt>read only</dt></dl>
pendingRequests
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

<dl><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li><b>options</b> — <i>Object or Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
createRequest
The given options object corresponds to the [Request][networking/Request] properties.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingcreaterequestobjectnetworkingrequest-options)

<dl><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li><b>uri</b> — <i>String</i></li><li><b>onLoadEnd</b> — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
get
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkinggetstring-uri-function-onloadend)

<dl><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li><b>uri</b> — <i>String</i></li><li><b>data</b> — <i>Any</i> — <i>optional</i></li><li><b>onLoadEnd</b> — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
post
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingpoststring-uri-any-data-function-onloadend)

<dl><dt>Prototype method of</dt><dd><i>Networking</i></dd><dt>Parameters</dt><dd><ul><li><b>uri</b> — <i>String</i></li><li><b>data</b> — <i>Any</i> — <i>optional</i></li><li><b>onLoadEnd</b> — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><i>Networking.Request</i></dd></dl>
put
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingputstring-uri-any-data-function-onloadend)

## Table of contents
    * [Networking](#networking)
    * [Networking](#networking)
    * [onRequest](#onrequest)
    * [protocol](#protocol)
    * [port](#port)
    * [host](#host)
    * [url](#url)
    * [language](#language)
    * [pendingRequests](#pendingrequests)
    * [createRequest](#createrequest)
    * [get](#get)
    * [post](#post)
    * [put](#put)
  * [*Networking.Request* Networking::delete(*String* uri, [*Any* data], *Function* onLoadEnd)](#networkingrequest-networkingdeletestring-uri-any-data-function-onloadend)
  * [Networking::resolveRequest(*Networking.Request* request)](#networkingresolverequestnetworkingrequest-request)
  * [*Networking.Request* Networking::createLocalRequest(*Object|Networking.Request* options)](#networkingrequest-networkingcreatelocalrequestobjectnetworkingrequest-options)
    * [Local requests](#local-requests)
    * [Requests to the server](#requests-to-the-server)

*Networking.Request* Networking::delete(*String* uri, [*Any* data], *Function* onLoadEnd)
-----------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingdeletestring-uri-any-data-function-onloadend)

Networking::resolveRequest(*Networking.Request* request)
----------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingresolverequestnetworkingrequest-request)

*Networking.Request* Networking::createLocalRequest(*Object|Networking.Request* options)
----------------------------------------------------------------------------------------

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

