# Routing

Neft on all platforms is using URIs to support different pages, just like a browser do for web pages.

All routes are placed in the `routes/` folder. Create it if needed.

Each file in this folder must exports a function and return an object of routes.

Let's consider how example */routes/user.js* may looks like:

```javascript
module.exports = (app) => {
    return {
        'get /users': {
            getData(callback) {
                callback(null, [{name: 'User1'}]);
            }
        }
    };
};
```

As you can see, you have access to the main [app](/api/app.html) object.

`get /users` creates a [route](/api/app-route.html).

It can be called in various ways:
- by a browser, when user open `/users` page,
- when user clicks on a link pointed to `/users` (using `<a href />` tag or [Item::linkUri](/api/renderer-item.html#linkuri)),
- by a crawler (e.g. GoogleBot),
- by you, when you sends a request to your server using `app.networking.get('/users', (err, data) => {})`,
- by you, when you sends a *local request*, using [app.networking.createLocalRequest](/api/networking.html#createlocalrequest).

Each route needs to return some data. To do this, declare the [getData](/api/app-route.html#getdata) function.

`callback` argument is a function.
It expects an *Error* instance (if thrown) and data as the second parameter.
This is a common pattern used in Neft callbacks.

`getData` is only one of the many methods you can declare in a route.
See API Reference of [Route](/api/app-route.html) for more.

## URI parameters

In URI you can specify parameters by putting them in curly brackets.

Matched parameters are available under the `this.request.params` object.

For instance, if you want to return user data based on the given *id*:

```javascript
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

For more strict parameters validation, you can use [Schema](/api/schema.html) module. Just declare it as `schema` in your route object.

If the received request does not correspond to the *schema*, route is omitted.

```javascript
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

If the request URI specifies some query, it's available under the `this.request.uri.query` object.

```javascript
// /users?limit=100&offset=200
// this.request.uri.query.limit == 100
// this.request.uri.query.offset == 200
```

## Custom attributes

All non-standard route properties are saved in the route object.

This functionality is more useful for the HTML rendering, where the route object is available in the HTML document by the `${context}` string.

```javascript
module.exports = (app) => {
    return {
        'get /users/nav': {
            defaultData: new Neft.List() // accessible in views by ${context.defaultData}
        }
    };
};
```

## Views integration
