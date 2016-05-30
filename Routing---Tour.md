> [Wiki](Home) ▸ [[Tour]] ▸ **Routing**

Routing
===

Routes are used to handle the user request based on the given URI.

Routes are placed in the `routes/` folder.

Each file must exports a function.

```javascript
// routes/user.js
module.exports = function(app){
    return {
        'get /users': {
            getData: function(callback){
                app.models.users.getUsers(callback);
            }
        }
    };
};
```

Returned object are changed to the routes.

`get /users` will be used, if there will be a request with the `GET` method and the `/users` URI.

To resolve the request with a data, declare the `Route::getData()` function.
`callback` function as the first argument expects an Error instance.
This is a common pattern used in Neft modules.

## URI parameters

The route URI can specify parameters which supports various URIs matching the pattern.

```javascript
// routes/user.js
module.exports = function(app){
    return {
        'get /user/{id}': {
            getData: function(callback){
                app.models.users.getById(this.request.params.id, callback);

                // e.g. for the URI '/user/12'
                // this.request.params.id == 12
            }
        }
    };
};
```

## Parameters schema

For more strict parameters validation, you can use the Schema module.

```javascript
// routes/user.js
module.exports = function(app){
    return {
        'get /user/{id}': {
            schema: {
                id: {
                    type: 'number',
                    min: 0
                }
            },
            getData: function(callback){
            }
        }
    };
};
```

## Request data

Data from the got request is available in the `this.request.data`.

## Request query

URI queries from the got request URI are available in the `this.request.uri.query`.

```javascript
// /users?limit=100&offset=200
// this.request.uri.query.limit == 100
```

## Custom attributes

All non-standard route properties are saved in the route object.

This functionality is more useful for the HTML rendering, where the route object is used as the global namespace in the HTML document.

```javascript
// routes/user.js
module.exports = function(app){
    return {
        'get /users/nav': {
            navOrSomething: [],
            getData: function(callback){
                callback(null, this.navOrSomething);
            }
        }
    };
};
```

Next article: [[Views - Tour]]
