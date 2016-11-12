Documents are automatically rendered by routes. 

By default, route uses a view equal its name, which is automatically generated from the route URI (parameters are removing).

The route name can be also defined manually in the route object.

If you want to use different view file, specify the route `toHTML` method.

```javascript
// routes/user.js
module.exports = (app) => {
    return {
        'get /user': {
            toHTML: {
                view: 'views/pages/user.html',
                template: 'views/templates/user.html',
                use: 'body'
            }
        }
    }
}
```

`toHTML.use` describes place, where the specified view file will be rendered in the template view.

```html
<!-- views/templates/user.html -->
<neft:use neft:fragment="body" />
```

```html
<!-- views/pages/user.html -->
<h1>Hello World!</h1>
```

Described `toHTML` syntax is a simplification but sufficient for most cases.
`toHTML` can be also a normal function which will render the view using the Document module API.
