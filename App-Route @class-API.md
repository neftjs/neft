> [Wiki](Home) ▸ [API Reference](API-Reference)

Route
> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#route-class)

getTemplateView
> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#document-routegettemplateviewstring-viewname)

Route
Access it with:
```javascript
module.exports = function(app){
  var Route = app.Route;
};
```
Acceptable syntaxes:
```javascript
*Route* app.Route(*String* method, *String* uri, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options)
*Route* app.Route(*String* methodWithUri, *Function* getData)
*Route* app.Route(*String* methodWithUri, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options)
*Route* app.Route(*String* uri, *Function* getData)
*Route* app.Route(*String* uri, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options)
*Route* app.Route(*String* method, *String* uri)
*Route* app.Route(*String* uri)
*Route* app.Route(*String* methodWithUri)
```

> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#route-routeobject-options)

method
> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#string-routemethod--getnetworkinguri-routeuriapp-routeapproute-routeroutestring-routenameschema-routeschemaany-routedataany-routeerrorfunction-routefactoryfunction-routeinitfunction-routegetdatafunction-callbackfunction-routedestroyfunction-routedestroyjsonfunction-routedestroytextfunction-routedestroyhtmlfunctionnetworkinguri-routeredirectnetworkingrequest-routerequestnetworkingresponse-routeresponsefunction-routenext)

toJSON
> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#any-routetojson)

toText
> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#string-routetotext)

toHTML
> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#document-routetohtml)

