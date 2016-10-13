Routes are used to handle the user request based on the given URI.

Routes are placed in the `routes/` folder.

Each file must exports a function returning an object.

```javascript
// routes/user.js
module.exports = (app) => {
    return {
        'get /users': {
            getData(callback) {
                app.models.users.getUsers(callback);
            }
        }
    };
};
```

Returned object are changed to routes.

`get /users` will be used, on a request with the `GET` method and the `/users` URI.

To resolve the request with a data, declare the `Route::getData()` function.
`callback` function as the first argument expects an Error instance (if thrown) and the data as the second parameter.
This is a common pattern used in Neft modules.

## URI parameters

In the URI you can specify parameters by putting the parameter name in curly brackets.

Matched parameters are available in the `this.request.params` object.

```javascript
// routes/user.js
module.exports = (app) => {
    return {
        'get /user/{id}': {
            getData(callback) {
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
module.exports = (app) => {
    return {
        'get /user/{id}': {
            schema: {
                id: {
                    type: 'number',
                    min: 0
                }
            },
            getData(callback){
            }
        }
    };
};
```

In the example above, `getData()` will be called only if the matched `id` is a positive number.

## Request data

If the request was called with some data (e.g. json) you can access it by `this.request.data`.

## Request query

URI queries from the got request URI are available by `this.request.uri.query`.

```javascript
// /users?limit=100&offset=200
// this.request.uri.query.limit == 100
```

## Custom attributes

All non-standard route properties are saved in the route object.

This functionality is more useful for the HTML rendering, where the route object is available in the HTML document using the `${root}` object.

```javascript
// routes/user.js
module.exports = (app) => {
    return {
        'get /users/nav': {
            defaultData: [],
            getData(callback) {
                callback(null, this.defaultData);
            }
        }
    };
};
```

Next article: [[Views - Tour]]
