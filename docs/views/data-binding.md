# Data binding

Signals
---

Signal is a function works similarly to the common events pattern.

It's used in various Neft modules to support automatically data-binding and in more cases there is no need to create them manually.

```javascript
const { signal } = Neft;

const onLoad = signal.create();
onLoad((src) => console.log(src));
onLoad.emit('/logo.png'); // logs '/logo.png'
```

Mutable data
---

Neft supports data-binding between routes, views and styles.
To ensure this goal, Neft uses observable versions of objects and arrays.

### Dict

This observable version of the JavaScript Object, emits `onChange` signals.
Data can be changed using the `set()` method.

```javascript
const { Dict } = Neft;

const data = new Dict;
data.set('pet', 'cat'); // will emit the onChange signal
data.pet; // cat
```

### List

This observable version of the JavaScript Array, emits `onChange`, `onInsert` and `onPop` signals.
Data can be changed using different various methods (e.g. `append()`, `insert()`, `pop()` and more).

```javascript
const { List } = Neft;

const data = new List;
data.append('tree');
data.insert(0, 'house');
data[0]; // house
data.pop();
data.length; // 1
```

> [Wiki](Home) ▸ [[Tour]] ▸ **Application Structure**

Application Structure
===

EcmaScript 6
---

```text
models/user.js
```

Neft parse all JavaScript files by **Babel** to support EcmaScript 6 code.

CoffeeScript support
---

```text
models/user.coffee
```

CoffeeScript files are automatically parsed into JavaScript.

Platform specified files
---

Models commonly are different on the client side and on the server side.

To use models, routes, styles or views only on the needed platform, before the file extension, specify:
- `node` or `server` for Node,
- `browser` or `client` for browsers,
- `android`, `native` or `client` for Android,
- `ios`, `native` or `client` for iOS.

For instance, `models/database.server.js` will be included only in the Node bundle.

Initialization file
---

`init.js` file is called before the app initialization.

It can be used to e.g. dynamically change the server port for the cloud service.

```javascript
module.exports = (NeftApp) => {
    const config = {};

    if (typeof process !== 'undefined'){
        config.port = process.env.OPENSHIFT_NODEJS_PORT;
    }

    return NeftApp(config);
};
```

Models
---

Neft application must provides some standard folders.
One of them is `models/`.

Models are commonly used to get and update the data from the database.

Each file must exports a function returning an object.

```javascript
// models/users.js
module.exports = (app) => {
    return {
        getUsers: function(callback){
            callback(new Error("No admin permissions"));
        }
    };
};
```

Models are available in the `app.models` object.

```javascript
module.exports = (app) => {
    app.models.users.getUsers(() => {});
};
```

Native
---

Routes
---

Static
---

Views
---

Tests
---

