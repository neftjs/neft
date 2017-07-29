# Networking

The whole networking communication is handled by the *Networking* module.

To use it, you have to refer by the `app.networking` instance. The `app` object is available in [routing](/routing.html), [views](/views.html) and other parts of your application.

The `app.networking` object by default uses HTTP connection.

## AJAX request

`app.networking` provides methods for basic REST requests:
- `get(uri, onLoadEnd)`,
- `post(uri, data, onLoadEnd)`,
- `put(uri, data, onLoadEnd)`,
- `delete(uri, data, onLoadEnd)`.

Example for routing:

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

Example for views:

```xml
<script>
    this.onRender(function () {
        this.context.app.networking.get("/users", (err, resp) => {});
    });
</script>
```

If you need to specify more options (e.g. expected type, headers, cookies) use `createRequest()` method.

For local requests use `createLocalRequest()` method.

## Custom headers

### X-Expected-Type

This HTTP header may be a `text`, `json` or `html`.

It's defined by the [Networking.Request::type](/api/networking-request.html#type) attribute.

[App.Route](/api/app-route.html) is using this property to return data in the needed format.
