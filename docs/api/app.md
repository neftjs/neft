# App

> **API Reference** ▸ **App**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee)


* * * 

### `app.config`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>

Config object from the *package.json* file.

Can be overriden in the *init.js* file.

### type

The `app` type (the default one) uses renderer on the client side.

The `game` type uses special renderer (if exists) focused on more performance goals.

The `text` type always return HTML document with no renderer on the client side.
It's used for the crawlers (e.g. GoogleBot) or browsers with no javascript support.

```javascript
// package.json
{
    "name": "neft.io app",
    "version": "0.1.0",
    "config": {
        "title": "My first application!",
        "protocol": "http",
        "port": 3000,
        "host": "localhost",
        "language": "en",
        "type": "app"
    }
}
// init.js
module.exports = function(NeftApp) {
    var app = NeftApp({ title: "Overridden title" });
    console.log(app.config);
    // {title: "My first application!", protocol: "http", port: ....}
};
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee)


* * * 

### `app.networking`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Networking</i></dd></dl>

Standard Networking instance used to communicate
with the server and to create local requests.

All routes created by the *App.Route* uses this networking.

HTTP protocol is used by default with the data specified in the *package.json*.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#networking-appnetworking)


* * * 

### `app.models`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>

Files from the *models* folder with objects returned by their exported functions.

```javascript
// models/user/permission.js
module.exports = function(app) {
    return {
        getPermission: function(id){}
    };
};
// controllers/user.js
module.exports = function(app) {
    return {
        get: function(req, res, callback) {
            var data = app.models['user/permission'].getPermission(req.params.userId);
            callback(null, data);
        }
    }
};
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#object-appmodels--)


* * * 

### `app.routes`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>

Files from the *routes* folder with objects returned by their exported functions.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#object-approutes--)


* * * 

### `app.styles`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>

Files from the *styles* folder as *Function*s
ready to create new *Item*s.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#object-appstyles--)


* * * 

### `app.views`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Object</i></dd><dt>Default</dt><dd><code>{}</code></dd></dl>

Files from the *views* folder as the *Document* instances.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#object-appviews--)


* * * 

### `app.resources`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Resources</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#resources-appresources)


* * * 

### `app.onReady()`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Called when all modules, views, styled etc. have been loaded.


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#signal-apponready)


* * * 

### `app.cookies`

<dl><dt>Static property of</dt><dd><i>app</i></dd><dt>Type</dt><dd><i>Dict</i></dd></dl>

On the client side, this object refers to the last received cookies
from the networking request.

On the server side, this cookies object are added into the each networking response.

By default, client has *clientId* and *sessionId* hashes.

```javascript
app.cookies.onChange(function(key){
    console.log('cookie changed', key, this[key]);
});
```

```xml
<h1>Your clientId</h1>
<em>${context.app.cookies.clientId}</em>
```


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/app/index.litcoffee#dict-appcookies)

