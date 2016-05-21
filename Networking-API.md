> [Wiki](Home) ▸ [API Reference](API-Reference)

Networking
This module cares about communication client-server and client internally.
Currently only the HTTP protocol is supported.
Access it with:
```javascript
var Networking = require('networking');
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-engine)

Networking
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-networkingobject-options)

onRequest
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#signal-networkingonrequestnetworkingrequest-request-networkingresponse-response)

protocol
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingprotocol)

port
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-integer-networkingport)

host
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinghost)

url
URL path contains a protocol, port and a host.
It can be set manually if the external address is different.
Otherwise it's created automatically.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingurl)

language
Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinglanguage)

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

createRequest
The given options object corresponds to the [Request][networking/Request] properties.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingcreaterequestobjectnetworkingrequest-options)

get
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkinggetstring-uri-function-onloadend)

post
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingpoststring-uri-any-data-function-onloadend)

put
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingputstring-uri-any-data-function-onloadend)

delete
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingdeletestring-uri-any-data-function-onloadend)

resolveRequest
> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingresolverequestnetworkingrequest-request)

createLocalRequest
Use this method to create a new [Request][networking/Request] and handle it.
The given options object corresponds to the [Request][networking/Request] properties.
Local and server requests are supported.

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
    * [delete](#delete)
    * [resolveRequest](#resolverequest)
    * [createLocalRequest](#createlocalrequest)
    * [Local requests](#local-requests)
    * [Requests to the server](#requests-to-the-server)

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

