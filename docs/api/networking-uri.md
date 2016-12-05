# Uri

> **API Reference** ▸ [Networking](/api/networking.md) ▸ **Uri**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/uri.litcoffee)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li></ul></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/uri.litcoffee#uriconstructorstring-uri)


* * * 

### `protocol`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `auth`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `host`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `path`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `params`

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>

Holds the last *Uri::match()* result.


* * * 

### `query`

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>


* * * 

### `hash`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `test()`

<dl><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Test whether the uri is valid with the given string.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/uri.litcoffee#boolean-uriteststring-uri)


* * * 

### `match()`

<dl><dt>Parameters</dt><dd><ul><li>uri — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>

Returns found parameters from the given string.

If the given uri is not valid with the uri, error will be raised.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/uri.litcoffee#object-urimatchstring-uri)


* * * 

### `toString()`

<dl><dt>Parameters</dt><dd><ul><li>params — <i>Object|Dict</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>

Parses the uri into a string.

The given params object is used to replace the uri parameters.

```javascript
var uri = new Networking.Uri('user/{name}');

console.log(uri.toString({name: 'Jane'}));
// /user/Jane

console.log(uri.toString());
// /user/{name}
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/networking/uri.litcoffee#string-uritostringobjectdict-params)

