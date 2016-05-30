> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Networking|Networking-API]] ▸ **Uri**

# Uri

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/uri.litcoffee#uri)

## Table of contents
* [Uri](#uri)
* [**Class** Uri](#class-uri)
  * [constructor](#constructor)
  * [protocol](#protocol)
  * [query](#query)
  * [match](#match)
  * [toString](#tostring)
* [Glossary](#glossary)

# *[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Uri

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/uri.litcoffee#class-uri)

##constructor
<dl><dt>Syntax</dt><dd><code>Uri::constructor(&#x2A;String&#x2A; uri)</code></dd><dt>Prototype method of</dt><dd><i>Uri</i></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/uri.litcoffee#constructor)

##protocol
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Uri::protocol</code></dd><dt>Prototype property of</dt><dd><i>Uri</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
Holds the last *Uri::match()* result.

##query
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Uri::query</code></dd><dt>Prototype property of</dt><dd><i>Uri</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
Test whether the uri is valid with the given string.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/uri.litcoffee#query)

##match
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Uri::match(&#x2A;String&#x2A; uri)</code></dd><dt>Prototype method of</dt><dd><i>Uri</i></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
Returns found parameters from the given string.

If the given uri is not valid with the uri, error will be raised.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/uri.litcoffee#match)

##toString
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Uri::toString([&#x2A;Object|Dict&#x2A; params])</code></dd><dt>Prototype method of</dt><dd><i>Uri</i></dd><dt>Parameters</dt><dd><ul><li>params — <i>Object|Dict</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
Parses the uri into a string.

The given params object is used to replace the uri parameters.

```javascript
var uri = new Networking.Uri('user/{name}');

console.log(uri.toString({name: 'Jane'}));
// /user/Jane

console.log(uri.toString());
// /user/{name}
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/networking/uri.litcoffee#tostring)

# Glossary

- [Networking.Uri](#class-uri)

