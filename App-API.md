> [Wiki](Home) ▸ [[API Reference|API-Reference]]

App
<dl><dt>Syntax</dt><dd><code>App @framework</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#app)

## Nested APIs

* [[Standard routes|App-Standard routes @learn-API]]
* [[Route|App-Route @class-API]]

app
<dl><dt>Syntax</dt><dd><code>&#x2A;Dict&#x2A; app</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#app)

config
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; app.config = {}</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#type)

networking
<dl><dt>Syntax</dt><dd><code>&#x2A;Networking&#x2A; app.networking</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Networking</i></dd></dl>
Standard Networking instance used to communicate
with the server and to create local requests.

All routes created by the *App.Route* uses this networking.

HTTP protocol is used by default with the data specified in the *package.json*.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#networking)

models
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; app.models = {}</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#models)

routes
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; app.routes = {}</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
Files from the *routes* folder with objects returned by their exported functions.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#routes)

styles
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; app.styles = {}</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
Files from the *styles* folder as *Function*s
ready to create new [Renderer.Item][renderer/Item]s.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#styles)

views
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; app.views = {}</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd><dt>Default</dt><dd><code>{}</code></dd></dl>
Files from the *views* folder as the [Document][document/File] instances.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#views)

resources
<dl><dt>Syntax</dt><dd><code>&#x2A;Resources&#x2A; app.resources</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#resources)

onReady
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; app.onReady()</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Called when all modules, views, styled etc. have been loaded.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#onready)

cookies
<dl><dt>Syntax</dt><dd><code>&#x2A;Dict&#x2A; app.cookies</code></dd><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Dict-API#class-dict">Dict</a></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/app/index.litcoffee#cookies)

