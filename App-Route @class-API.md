Route @class
============

*Document* Route.getTemplateView(*String* viewName)
---------------------------------------------------

*Route* Route(*Object* options)
-------------------------------

Access it with:
```javascript
module.exports = function(app){
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

*Any* Route::toJSON()
---------------------

*String* Route::toText()
------------------------

*Document* Route::toHTML()
--------------------------

