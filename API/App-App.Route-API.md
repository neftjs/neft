> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[App|App-API]] ▸ **Route**

#Route
<dl><dt>Syntax</dt><dd><code>App.Route</code></dd><dt>Static property of</dt><dd><i>App</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#route)

## Table of contents
* [Route](#route)
* [**Class** Route](#class-route)
  * [getTemplateView](#gettemplateview)
  * [constructor](#constructor)
  * [method](#method)
  * [toJSON](#tojson)
  * [toText](#totext)
  * [toHTML](#tohtml)

# **Class** Route

> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#class-route)

##getTemplateView
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Route.getTemplateView(&#x2A;String&#x2A; viewName)</code></dd><dt>Static method of</dt><dd><i>Route</i></dd><dt>Parameters</dt><dd><ul><li>viewName — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#gettemplateview)

##constructor
<dl><dt>Syntax</dt><dd><code>Route::constructor(&#x2A;Object&#x2A; options)</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Parameters</dt><dd><ul><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd></dl>
Access it with:
```javascript
module.exports = function(app) {
    var Route = app.Route;
};
```

Acceptable syntaxes:
```javascript
*Route* app.Route(*String* method, *String* uri, [Object](/Neft-io/neft/wiki/Utils-API#isobject) options)
*Route* app.Route(*String* methodWithUri, *Function* getData)
*Route* app.Route(*String* methodWithUri, [Object](/Neft-io/neft/wiki/Utils-API#isobject) options)
*Route* app.Route(*String* uri, *Function* getData)
*Route* app.Route(*String* uri, [Object](/Neft-io/neft/wiki/Utils-API#isobject) options)
*Route* app.Route(*String* method, *String* uri)
*Route* app.Route(*String* uri)
*Route* app.Route(*String* methodWithUri)
```

> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#constructor)

##method
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Route::method = `'get'`</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'get'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#method)

##toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; Route::toJSON()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#tojson)

##toText
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Route::toText()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#totext)

##toHTML
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Route::toHTML()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/ff48820399c4a74536b2bb1aeedad9a10e28ae9e/src/app/route.litcoffee#tohtml)

