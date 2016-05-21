> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
App
> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#app-framework)

<dl><dt>Type</dt><dd><i>Dict</i></dd></dl>
app
> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#dict-app)

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
config
Config object from the *package.json* file.
Can be overriden in the *init.js* file.

## Table of contents
    * [App](#app)
    * [app](#app)
    * [config](#config)
    * [type](#type)
    * [networking](#networking)
    * [models](#models)
    * [routes](#routes)
    * [styles](#styles)
    * [views](#views)
  * [*Resources* app.resources](#resources-appresources)
  * [*Signal* app.onReady()](#signal-apponready)
  * [*Dict* app.cookies](#dict-appcookies)

### type

The `app` type (the default one) uses renderer on the client side.
The `game` type uses special renderer (if exists) focused on more performance goals.
The `text` type always return HTML document with no renderer on the client side.
It's used for the crawlers (e.g. GoogleBot) or browsers with no javascript support.
```javascript
`// package.json
`{
`   "name": "neft.io app",
`   "version": "0.1.0",
`   "config": {
`       "title": "My first application!",
`       "protocol": "http",
`       "port": 3000,
`       "host": "localhost",
`       "language": "en",
`       "type": "app"
`   }
`}
`
`// init.js
`module.exports = function(NeftApp){
`   var app = NeftApp({ title: "Overridden title" });
`   console.log(app.config);
`   // {title: "My first application!", protocol: "http", port: ....}
`};
```

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#type)

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Networking</i></dd></dl>
networking
Standard Networking instance used to communicate
with the server and to create local requests.
All routes created by the *App.Route* uses this networking.
HTTP protocol is used by default with the data specified in the *package.json*.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#networking-appnetworking)

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
models
Files from the *models* folder with objects returned by their exported functions.
```javascript
`// models/user/permission.js
`module.exports = function(app){
`   return {
`       getPermission: function(id){}
`   };
`};
`
`// controllers/user.js
`module.exports = function(app){
`   return {
`       get: function(req, res, callback){
`           var data = app.models['user/permission'].getPermission(req.params.userId);
`           callback(null, data);
`       }
`   }
`};
```

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#object-appmodels--)

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
routes
Files from the *routes* folder with objects returned by their exported functions.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#object-approutes--)

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
styles
Files from the *styles* folder as *Function*s
ready to create new [Renderer.Item][renderer/Item]s.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#object-appstyles--)

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
views
Files from the *views* folder as the [Document][document/File] instances.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#object-appviews--)

*Resources* app.resources
-------------------------

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#resources-appresources)

[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) app.onReady()
----------------------

Called when all modules, views, styled etc. have been loaded.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#signal-apponready)

[*Dict*](/Neft-io/neft/wiki/Dict-API.md#class-dict) app.cookies
------------------

On the client side, this object refers to the last received cookies
from the networking request.
On the server side, this cookies object are added into the each networking response.
By default, client has *clientId* and *sessionId* hashes.
```javascript
`app.cookies.onChange(function(key){
`   console.log('cookie changed', key, this[key]);
`});
```
```xml
<h1>Your clientId</h1>
<em>${app.cookies.clientId}</em>
```

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#dict-appcookies)

