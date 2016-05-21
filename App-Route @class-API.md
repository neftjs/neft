> [Wiki](Home) ▸ [API Reference](API-Reference)

Route
<dl><dt>Syntax</dt><dd><code>Route @class</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/route.litcoffee#route-class)

getTemplateView
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Route.getTemplateView(&#x2A;String&#x2A; viewName)</code></dd><dt>Static method of</dt><dd><i>Route</i></dd><dt>Parameters</dt><dd><ul><li>viewName — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/route.litcoffee#document-routegettemplateviewstring-viewname)

Route
<dl><dt>Syntax</dt><dd><code>&#x2A;Route&#x2A; Route(&#x2A;Object&#x2A; options)</code></dd><dt>Parameters</dt><dd><ul><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><i>Route</i></dd></dl>
Access it with:
```javascript
module.exports = function(app){
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/route.litcoffee#route-routeobject-options)

method
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Route::method = 'get'</code></dd><dt>Prototype property of</dt><dd><i>Route</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'get'</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/route.litcoffee#string-routemethod--getnetworkinguri-routeuriapp-routeapproute-routeroutestring-routenameschema-routeschemaany-routedataany-routeerrorfunction-routefactoryfunction-routeinitfunction-routegetdatafunction-callbackfunction-routedestroyfunction-routedestroyjsonfunction-routedestroytextfunction-routedestroyhtmlfunctionnetworkinguri-routeredirectnetworkingrequest-routerequestnetworkingresponse-routeresponsefunction-routenext)

toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; Route::toJSON()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/route.litcoffee#any-routetojson)

toText
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Route::toText()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/route.litcoffee#string-routetotext)

toHTML
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Route::toHTML()</code></dd><dt>Prototype method of</dt><dd><i>Route</i></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/route.litcoffee#document-routetohtml)

