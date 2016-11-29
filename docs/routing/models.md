# Models

Models are commonly used to get and update data from a database.

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

Models are available under the `app.models` object.

```javascript
// routes/index.js
module.exports = (app) => {
    return {
        '/': {
            getData(callback) {
                app.models.users.getUsers(callback);
            }
        }
    }
};
```
