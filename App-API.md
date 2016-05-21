> [Wiki](Home) ▸ [API Reference](API-Reference)

App
<dl><dt>Syntax</dt><dd>App @framework</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#app-framework)

app
<dl><dt>Syntax</dt><dd>[*Dict*](/Neft-io/neft/wiki/Dict-API.md#class-dict) app</dd><dt>Type</dt><dd><i>Dict</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#dict-app)

config
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) app.config = {}</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
Config object from the *package.json* file.
Can be overriden in the *init.js* file.

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

networking
<dl><dt>Syntax</dt><dd>*Networking* app.networking</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Networking</i></dd></dl>
Standard Networking instance used to communicate
with the server and to create local requests.
All routes created by the *App.Route* uses this networking.
HTTP protocol is used by default with the data specified in the *package.json*.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#networking-appnetworking)

models
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) app.models = {}</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
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

routes
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) app.routes = {}</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
Files from the *routes* folder with objects returned by their exported functions.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#object-approutes--)

styles
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) app.styles = {}</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
Files from the *styles* folder as *Function*s
ready to create new [Renderer.Item][renderer/Item]s.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#object-appstyles--)

views
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) app.views = {}</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
Files from the *views* folder as the [Document][document/File] instances.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#object-appviews--)

resources
<dl><dt>Syntax</dt><dd>*Resources* app.resources</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#resources-appresources)

onReady
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) app.onReady()</dd><dt>Static method of</dt><dd><i>app</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Called when all modules, views, styled etc. have been loaded.

> [`Source`](/Neft-io/neft/tree/master/src/app/index.litcoffee#signal-apponready)

cookies
<dl><dt>Syntax</dt><dd>[*Dict*](/Neft-io/neft/wiki/Dict-API.md#class-dict) app.cookies</dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Dict</i></dd></dl>
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

