> [Wiki](Home) ▸ [[Tour]] ▸ **App Structure**

App Structure
===

CoffeeScript support
---

```text
models/user.coffee
```

CoffeeScript files are automatically parsed.

Platform specified files
---

Models commonly are different on the client side and on the server side.

To use models, routes, styles or views only on the needed platform, before the file extension, specify:
- `node` or `server` for Node,
- `browser` or `client` for browsers,
- `android`, `native` or `client` for Android,
- `ios`, `native` or `client` for iOS.

```text
models/database.server.js
```

Initialization file
---

`init.js` file is called before the app initialization.

It can be used to e.g. dynamically change the server port for the cloud service.

```javascript
module.exports = function(NeftApp){
    var config = {};

    if (typeof process !== 'undefined'){
        config.port = process.env.OPENSHIFT_NODEJS_PORT;
    }

    var app = NeftApp(config);
};
```

Models
---

Models are a JavaScript files operating on data.
In Neft, they are placed in the `models/` folder.

Each file must exports a function.

```javascript
// models/users.js
module.exports = function(app){
    return {
        getUsers: function(callback){
            callback(new Error("No admin permissions"));
        }
    };
};
```

Models are available in the `app.models` object.

```javascript
module.exports = function(app){
    app.models.users.getUsers(function(){});
};
```

Next article: [[Data Binding - Tour]]
