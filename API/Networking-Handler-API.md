> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Networking|Networking-API]] ▸ **Handler**

# Handler

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#handler)

## Table of contents
* [Handler](#handler)
* [**Class** Handler](#class-handler)
  * [constructor](#constructor)
  * [method](#method)
  * [uri](#uri)
  * [*Schema* Handler::schema = null](#schema-handlerschema--null)
  * [callback](#callback)
  * [exec](#exec)
  * [toString](#tostring)
* [Glossary](#glossary)

# **Class** Handler

Represents a callback function called on the request.

Each handler must determine an uri, which is compared with the got request URI.

You should use `createHandler()` to create a functional handler.

Access it with:
```javascript
var Networking = require('networking');
var Handler = Networking.Handler;
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#class-handler)

##constructor
<dl><dt>Syntax</dt><dd><code>Handler::constructor(&#x2A;Object&#x2A; options)</code></dd><dt>Prototype method of</dt><dd><i>Handler</i></dd><dt>Parameters</dt><dd><ul><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#constructor)

##method
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Handler::method</code></dd><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
Describes which type of the request, this handler can handle.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#method)

##uri
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Uri&#x2A; Handler::uri</code></dd><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Networking-Uri-API#class-uri">Networking.Uri</a></dd></dl>
This property is compared with the request uri.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#uri)

## *Schema* Handler::schema = null

Used to determine whether the request uri is valid and can be handled by the handler callback.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#schema-handlerschema--null)

##callback
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Handler::callback</code></dd><dt>Prototype property of</dt><dd><i>Handler</i></dd><dt>Type</dt><dd><i>Function</i></dd></dl>
Function used to handle the request.

It's called with three parameters: [Networking.Request](/Neft-io/neft/wiki/Networking-Request-API#class-request), [Networking.Response](/Neft-io/neft/wiki/Networking-Response-API#class-response) and
a *next* function.

If the *next* function is called, the next handler is checked.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#callback)

##exec
<dl><dt>Syntax</dt><dd><code>Handler::exec(&#x2A;Networking.Request&#x2A; request, &#x2A;Networking.Response&#x2A; response, &#x2A;Function&#x2A; next)</code></dd><dt>Prototype method of</dt><dd><i>Handler</i></dd><dt>Parameters</dt><dd><ul><li>request — <a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></li><li>response — <a href="/Neft-io/neft/wiki/Networking-Response-API#class-response">Networking.Response</a></li><li>next — <i>Function</i></li></ul></dd></dl>
Executes the handler, that is:
 - compares the uri with the request,
 - validates the request uri with the schema,
 - calls the handler callback.

It's internally called by the `createRequest()`.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#exec)

##toString
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Handler::toString()</code></dd><dt>Prototype method of</dt><dd><i>Handler</i></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Returns a string describing the handler.

```javascript
"get /users/{name}"
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/handler.litcoffee#tostring)

# Glossary

- [Networking.Handler](#class-handler)

