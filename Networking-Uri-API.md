> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Uri**

Uri
===

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/uri.litcoffee#uri)

## Table of contents
* [Uri](#uri)
    * [Uri](#uri)
    * [protocol](#protocol)
    * [query](#query)
    * [match](#match)
    * [toString](#tostring)

Uri
<dl><dt>Syntax</dt><dd><code>&#x2A;Uri&#x2A; Uri(&#x2A;String&#x2A; uri)</code></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Uri</i></dd></dl>
Represents an uri string with parameters.
The parameter must be wrapped by the curly brackets **{…}**.
**Rest parameters** are not greedy and are wrapped by the **{…*}** or just **…***.
Rest parameters don't have to be named (**{*}** is allowed).
```javascript
var uri = new Networking.Uri('articles/{pageStart}/{pageEnd}');
console.log(uri.match('articles/2/4'));
// { pageStart: '2', pageEnd: '4' }
var uri = new Networking.Uri('comments/{path*}/{page}');
console.log(uri.match('comments/article/world/test-article/4'));
// { path: 'article/world/test-article', page: '4' }
```
Access it with:
```javascript
var Networking = require('networking');
var Uri = Networking.Uri;
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/uri.litcoffee#uri-uristring-uri)

protocol
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Uri::protocol</code></dd><dt>Prototype property of</dt><dd><i>Uri</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
Holds the last *Uri::match()* result.

query
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Uri::query</code></dd><dt>Prototype property of</dt><dd><i>Uri</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></dd></dl>
Test whether the uri is valid with the given string.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/uri.litcoffee#object-uriquerystring-urihashboolean-uriteststring-uri)

match
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Uri::match(&#x2A;String&#x2A; uri)</code></dd><dt>Prototype method of</dt><dd><i>Uri</i></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></dd></dl>
Returns found parameters from the given string.
If the given uri is not valid with the uri, error will be raised.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/uri.litcoffee#object-urimatchstring-uri)

toString
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Uri::toString([&#x2A;Object|Dict&#x2A; params])</code></dd><dt>Prototype method of</dt><dd><i>Uri</i></dd><dt>Parameters</dt><dd><ul><li>params — <i>Object or Dict</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Parses the uri into a string.
The given params object is used to replace the uri parameters.
```javascript
var uri = new Networking.Uri('user/{name}');
console.log(uri.toString({name: 'Jane'}));
// /user/Jane
console.log(uri.toString());
// /user/{name}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/networking/uri.litcoffee#string-uritostringobjectdict-params)

