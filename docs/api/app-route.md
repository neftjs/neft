# Route

> **API Reference** ▸ [App](/api/app.md) ▸ **Route**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/route.litcoffee)


* * * 

### `Route.getTemplateView()`

<dl><dt>Static method of</dt><dd><i>Route</i></dd><dt>Parameters</dt><dd><ul><li>viewName — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/route.litcoffee#document-routegettemplateviewstring-viewname)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>options — <i>Object</i></li></ul></dd></dl>

Access it with:
```javascript
module.exports = function(app) {
    var Route = app.Route;
};
```

Acceptable syntaxes:
```javascript
*Route* app.Route(*String* method, *String* uri, *Object* options)
*Route* app.Route(*String* methodWithUri, *Function* getData)
*Route* app.Route(*String* methodWithUri, *Object* options)
*Route* app.Route(*String* uri, *Function* getData)
*Route* app.Route(*String* uri, *Object* options)
*Route* app.Route(*String* method, *String* uri)
*Route* app.Route(*String* uri)
*Route* app.Route(*String* methodWithUri)
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/route.litcoffee#routeconstructorobject-options)


* * * 

### `method`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>&#39;get&#39;</code></dd></dl>


* * * 

### `uri`

<dl><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>


* * * 

### `app`

<dl><dt>Type</dt><dd><i>App</i></dd></dl>


* * * 

### `route`

<dl><dt>Type</dt><dd><i>App.Route</i></dd></dl>


* * * 

### `name`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `schema`

<dl><dt>Type</dt><dd><i>Schema</i></dd></dl>


* * * 

### `data`

<dl><dt>Type</dt><dd><i>Any</i></dd></dl>


* * * 

### `error`

<dl><dt>Type</dt><dd><i>Any</i></dd></dl>


* * * 

### `factory()`

<dl><dt>Returns</dt><dd><i>Function</i></dd></dl>


* * * 

### `init()`

<dl><dt>Returns</dt><dd><i>Function</i></dd></dl>


* * * 

### `getData()`

<dl><dt>Parameters</dt><dd><ul><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>


* * * 

### `destroy()`

<dl><dt>Returns</dt><dd><i>Function</i></dd></dl>


* * * 

### `destroyJSON()`

<dl><dt>Returns</dt><dd><i>Function</i></dd></dl>


* * * 

### `destroyText()`

<dl><dt>Returns</dt><dd><i>Function</i></dd></dl>


* * * 

### `destroyHTML()`

<dl><dt>Returns</dt><dd><i>Function</i></dd></dl>


* * * 

### `redirect`

<dl><dt>Type</dt><dd><i>Networking.Uri</i></dd></dl>

Can be also a function. May returns a *Networking.Uri*, any String or `undefined`.


* * * 

### `request`

<dl><dt>Type</dt><dd><i>Networking.Request</i></dd></dl>


* * * 

### `response`

<dl><dt>Type</dt><dd><i>Networking.Response</i></dd></dl>


* * * 

### `next()`

<dl><dt>Returns</dt><dd><i>Function</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/route.litcoffee#function-routenext)


* * * 

### `toJSON()`

<dl><dt>Returns</dt><dd><i>Any</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/route.litcoffee#any-routetojson)


* * * 

### `toText()`

<dl><dt>Returns</dt><dd><i>String</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/route.litcoffee#string-routetotext)


* * * 

### `toHTML()`

<dl><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/route.litcoffee#document-routetohtml)

