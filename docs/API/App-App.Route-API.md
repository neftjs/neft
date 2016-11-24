> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[App|App-API]] ▸ **Route**

#Route
<dl><dt>Syntax</dt><dd><code>App.Route</code></dd><dt>Static property of</dt><dd><i>App</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee#approute)

## Table of contents
* [Route](#route)
* [**Class** Route](#class-route)
  * [getTemplateView](#gettemplateview)
  * [constructor](#constructor)
  * [method](#method)
  * [uri](#uri)
  * [app](#app)
  * [route](#route)
  * [name](#name)
  * [schema](#schema)
  * [data](#data)
  * [error](#error)
  * [factory](#factory)
  * [init](#init)
  * [getData](#getdata)
  * [destroy](#destroy)
  * [destroyJSON](#destroyjson)
  * [destroyText](#destroytext)
  * [destroyHTML](#destroyhtml)
  * [*Function*|*Networking.Uri* Route::redirect](#functionnetworkinguri-routeredirect)
  * [request](#request)
  * [response](#response)
  * [next](#next)
  * [toJSON](#tojson)
  * [toText](#totext)
  * [toHTML](#tohtml)

# **Class** Route

> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee)

##getTemplateView
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Route.getTemplateView(&#x2A;String&#x2A; viewName)</code></dd><dt>Static method of</dt><dd><i>Route</i></dd><dt>Parameters</dt><dd><ul><li>viewName — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee#document-routegettemplateviewstring-viewname)

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

> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee#routeconstructorobject-options)

##method
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Route::method = `'get'`</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'get'</code></dd></dl>
##uri
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Uri&#x2A; Route::uri</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Networking-Uri-API#class-uri">Networking.Uri</a></dd></dl>
##app
<dl><dt>Syntax</dt><dd><code>&#x2A;App&#x2A; Route::app</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>App</i></dd></dl>
##route
<dl><dt>Syntax</dt><dd><code>&#x2A;App.Route&#x2A; Route::route</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>App.Route</i></dd></dl>
##name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Route::name</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
##schema
<dl><dt>Syntax</dt><dd><code>&#x2A;Schema&#x2A; Route::schema</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>Schema</i></dd></dl>
##data
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; Route::data</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
##error
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; Route::error</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
##factory
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::factory()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##init
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::init()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##getData
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::getData([&#x2A;Function&#x2A; callback])</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Parameters</dt><dd><ul><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##destroy
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::destroy()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##destroyJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::destroyJSON()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##destroyText
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::destroyText()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
##destroyHTML
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::destroyHTML()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
## *Function*|[Networking.Uri](/Neft-io/neft/wiki/Networking-Uri-API#class-uri) Route::redirect

##request
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Request&#x2A; Route::request</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Networking-Request-API#class-request">Networking.Request</a></dd></dl>
##response
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking.Response&#x2A; Route::response</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Networking-Response-API#class-response">Networking.Response</a></dd></dl>
##next
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Route::next()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee#function-routenext)

##toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; Route::toJSON()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee#any-routetojson)

##toText
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Route::toText()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee#string-routetotext)

##toHTML
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Route::toHTML()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/2c087cdd2c61477a6c35b8e1fdc0fcfea8d41eca/src/app/route.litcoffee#document-routetohtml)

