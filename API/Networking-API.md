> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Networking**

# Networking

This module cares about communication client-server and client internally.

Currently only the HTTP protocol is supported.

Access it with:
```javascript
var Networking = require('networking');
```

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee)

## Nested APIs

* [[Handler|Networking-Handler-API]]
* [[Request|Networking-Request-API]]
* [[Response|Networking-Response-API]]
  * [[Response Error|Networking-Response Error-API]]
* [[Uri|Networking-Uri-API]]

## Table of contents
* [Networking](#networking)
* [**Class** Networking](#class-networking)
  * [constructor](#constructor)
  * [onRequest](#onrequest)
  * [protocol](#protocol)
  * [port](#port)
  * [host](#host)
  * [url](#url)
  * [language](#language)
  * [pendingRequests](#pendingrequests)
  * [createHandler](#createhandler)
  * [createRequest](#createrequest)
  * [get](#get)
  * [post](#post)
  * [put](#put)
  * [delete](#delete)
  * [resolveRequest](#resolverequest)
  * [createLocalRequest](#createlocalrequest)
    * [Local requests](#local-requests)
    * [Requests to the server](#requests-to-the-server)
* [Glossary](#glossary)

# **Class** Networking

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee)

##constructor
<dl><dt>Syntax</dt><dd><code>Networking::constructor(&#x2A;Object&#x2A; options)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd></dl>
Options:
- `allowAllOrigins` determines whether *Access-Control-Allow-Origin* should return wildcard,
  false by default

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkingconstructorobject-options)

##onRequest
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Networking::onRequest(&#x2A;Networking.Request&#x2A; request, &#x2A;Networking.Response&#x2A; response)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>request — <a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></li><li>response — <a href="/Neft-io/neft/wiki/Networking-Response-API#class-response">Networking.Response</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#signal-networkingonrequestnetworkingrequest-request-networkingresponse-response)

##protocol
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Networking::protocol</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#readonly-string-networkingprotocol)

##port
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Integer&#x2A; Networking::port</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#readonly-integer-networkingport)

##host
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Networking::host</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#readonly-string-networkinghost)

##url
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Networking::url</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
URL path contains a protocol, port and a host.

It can be set manually if the external address is different.
Otherwise it's created automatically.

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#readonly-string-networkingurl)

##language
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Networking::language</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
Indicates the application language regarding to BCP47 (e.g. 'en', 'en-US').

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#readonly-string-networkinglanguage)

##pendingRequests
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;List&#x2A; Networking::pendingRequests</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/List-API#class-list">List</a></dd><dt>Read Only</dt></dl>
##createHandler
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Handler&#x2A; Networking::createHandler(&#x2A;Object&#x2A; options)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Networking-Handler-API#class-handler">Networking.Handler</a></dd></dl>
Use this method to create a new [Networking.Handler](/Neft-io/neft/wiki/Networking-Handler-API#class-handler).

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

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkinghandler-networkingcreatehandlerobject-options)

##createRequest
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Request&#x2A; Networking::createRequest(&#x2A;Object|Networking.Request&#x2A; options)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object|Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></dd></dl>
The given options object corresponds to the [Networking.Request](/Neft-io/neft/wiki/Networking-Request-API#class-request) properties.

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkingrequest-networkingcreaterequestobjectnetworkingrequest-options)

##get
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Request&#x2A; Networking::get(&#x2A;String&#x2A; uri, &#x2A;Function&#x2A; onLoadEnd)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkingrequest-networkinggetstring-uri-function-onloadend)

##post
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Request&#x2A; Networking::post(&#x2A;String&#x2A; uri, [&#x2A;Any&#x2A; data], &#x2A;Function&#x2A; onLoadEnd)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkingrequest-networkingpoststring-uri-any-data-function-onloadend)

##put
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Request&#x2A; Networking::put(&#x2A;String&#x2A; uri, [&#x2A;Any&#x2A; data], &#x2A;Function&#x2A; onLoadEnd)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkingrequest-networkingputstring-uri-any-data-function-onloadend)

##delete
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Request&#x2A; Networking::delete(&#x2A;String&#x2A; uri, [&#x2A;Any&#x2A; data], &#x2A;Function&#x2A; onLoadEnd)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li><li>data — <i>Any</i> — <i>optional</i></li><li>onLoadEnd — <i>Function</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkingrequest-networkingdeletestring-uri-any-data-function-onloadend)

##resolveRequest
<dl><dt>Syntax</dt><dd><code>Networking::resolveRequest(&#x2A;Networking.Request&#x2A; request)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>request — <a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee#networkingresolverequestnetworkingrequest-request)

##createLocalRequest
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Request&#x2A; Networking::createLocalRequest(&#x2A;Object|Networking.Request&#x2A; options)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Networking-API#class-networking">Networking</a></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object|Networking.Request</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/2a55740be84e38fd33bba22916304f1dd143b871/src/networking/index.litcoffee)

# Glossary

- [Networking](#class-networking)
- [HTTP](#class-networking)

