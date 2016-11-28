# Networking

HTTP networking connection is available under the `app.networking` Networking instance. Commonly used classes in routes are `Networking.Request` and `Networking.Response`.

Neft uses special HTTP header `X-Expected-Type`. Routes are polymorphic. They return the same data in various formats (currently supported are `text`, `json` and `html`) for the same URI.

By default, routes return:
- `html` for crawlers and local requests,
- `json` for manual client-server and local requests.

### AJAX request

`app.networking` provides methods for the basic REST resources:
- `get(uri, onLoadEnd)`,
- `post(uri, data, onLoadEnd)`,
- `put(uri, data, onLoadEnd)`,
- `delete(uri, data, onLoadEnd)`.

```javascript
// models/user.client.js
module.exports = (app) => {
    return {
        getUsers(callback) {
            app.networking.get("/users", callback);
        }
    }
};
```

If you need to specify more options (e.g. expected type, headers, cookies) use the `createRequest()` method.

For local requests use the `createLocalRequest()` method.

Next article: [[Native Communication - Tour]]
