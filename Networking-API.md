> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Networking @engine**

Networking @engine
==================

This module cares about communication client-server and client internally.
Currently only the HTTP protocol is supported.
Access it with:
```javascript
var Networking = require('networking');
```

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-engine)

## Table of contents
  * [Networking(options)](#networking-networkingobject-options)
  * [onRequest(*Networking.Request* request, *Networking.Response* response)](#signal-networkingonrequestnetworkingrequest-request-networkingresponse-response)
  * [protocol](#readonly-string-networkingprotocol)
  * [port](#readonly-integer-networkingport)
  * [host](#readonly-string-networkinghost)
  * [url](#readonly-string-networkingurl)
  * [language](#readonly-string-networkinglanguage)
  * [pendingRequests](#readonly-list-networkingpendingrequests)
  * [*Networking.Request* createRequest(*Object|Networking.Request* options)](#networkingrequest-networkingcreaterequestobjectnetworkingrequest-options)
  * [*Networking.Request* get(uri, onLoadEnd)](#networkingrequest-networkinggetstring-uri-function-onloadend)
  * [*Networking.Request* post(uri, [data], onLoadEnd)](#networkingrequest-networkingpoststring-uri-any-data-function-onloadend)
  * [*Networking.Request* put(uri, [data], onLoadEnd)](#networkingrequest-networkingputstring-uri-any-data-function-onloadend)
  * [*Networking.Request* delete(uri, [data], onLoadEnd)](#networkingrequest-networkingdeletestring-uri-any-data-function-onloadend)
  * [resolveRequest(*Networking.Request* request)](#networkingresolverequestnetworkingrequest-request)
  * [*Networking.Request* createLocalRequest(*Object|Networking.Request* options)](#networkingrequest-networkingcreatelocalrequestobjectnetworkingrequest-options)
    * [Local requests](#local-requests)
    * [Requests to the server](#requests-to-the-server)

*Networking* Networking(*Object* options)
-----------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networking-networkingobject-options)

*Signal* Networking::onRequest(*Networking.Request* request, *Networking.Response* response)
--------------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#signal-networkingonrequestnetworkingrequest-request-networkingresponse-response)

ReadOnly *String* Networking::protocol
--------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingprotocol)

ReadOnly [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Networking::port
-----------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-integer-networkingport)

ReadOnly *String* Networking::host
----------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinghost)

ReadOnly *String* Networking::url
---------------------------------

URL path contains a protocol, port and a host.
It can be set manually if the external address is different.
Otherwise it's created automatically.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkingurl)

ReadOnly *String* Networking::language
--------------------------------------

Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#readonly-string-networkinglanguage)

ReadOnly [*List*](/Neft-io/neft/wiki/List-API.md#class-list) Networking::pendingRequests
-------------------------------------------
*Networking.Handler* Networking::createHandler(*Object* options)
----------------------------------------------------------------

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

*Networking.Request* Networking::createRequest(*Object|Networking.Request* options)
-----------------------------------------------------------------------------------

The given options object corresponds to the [Request][networking/Request] properties.

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingcreaterequestobjectnetworkingrequest-options)

*Networking.Request* Networking::get(*String* uri, *Function* onLoadEnd)
------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkinggetstring-uri-function-onloadend)

*Networking.Request* Networking::post(*String* uri, [*Any* data], *Function* onLoadEnd)
---------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingpoststring-uri-any-data-function-onloadend)

*Networking.Request* Networking::put(*String* uri, [*Any* data], *Function* onLoadEnd)
--------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/networking/index.litcoffee#networkingrequest-networkingputstring-uri-any-data-function-onloadend)

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

