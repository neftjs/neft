> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Route @class**

Route @class
============

> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#route-class)

## Table of contents
  * [Route.getTemplateView(viewName)](#document-routegettemplateviewstring-viewname)
  * [Route(options)](#route-routeobject-options)
  * [method = 'get'](#string-routemethod--get)
  * [toJSON()](#any-routetojson)
  * [toText()](#string-routetotext)
  * [toHTML()](#document-routetohtml)

*Document* Route.getTemplateView(*String* viewName)
---------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#document-routegettemplateviewstring-viewname)

*Route* Route([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options)
-------------------------------

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

*String* Route::method = 'get'
------------------------------
*Networking.Uri* Route::uri
---------------------------
*App* Route::app
----------------
*Route* Route::route
--------------------
*String* Route::name
--------------------
*Schema* Route::schema
----------------------
*Any* Route::data
-----------------
*Any* Route::error
------------------
*Function* Route::factory()
---------------------------
*Function* Route::init()
------------------------
*Function* Route::getData([*Function* callback])
------------------------------------------------
*Function* Route::destroy()
---------------------------
*Function* Route::destroyJSON()
-------------------------------
*Function* Route::destroyText()
-------------------------------
*Function* Route::destroyHTML()
-------------------------------
*Function|Networking.Uri* Route::redirect
-----------------------------------------
*Networking.Request* Route::request
-----------------------------------
*Networking.Response* Route::response
-------------------------------------
*Function* Route::next()
------------------------

> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#string-routemethod--getnetworkinguri-routeuriapp-routeapproute-routeroutestring-routenameschema-routeschemaany-routedataany-routeerrorfunction-routefactoryfunction-routeinitfunction-routegetdatafunction-callbackfunction-routedestroyfunction-routedestroyjsonfunction-routedestroytextfunction-routedestroyhtmlfunctionnetworkinguri-routeredirectnetworkingrequest-routerequestnetworkingresponse-routeresponsefunction-routenext)

*Any* Route::toJSON()
---------------------

> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#any-routetojson)

*String* Route::toText()
------------------------

> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#string-routetotext)

*Document* Route::toHTML()
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/app/route.litcoffee#document-routetohtml)

