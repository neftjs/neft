> [Wiki](Home) ▸ [[Tour]] ▸ **Views**

Views
===

Views are used to serve HTML documents for crawlers (e.g. GoogleBot), browsers with no JavaScript support and, on the client side, to render needed elements.

In Neft, all views must be placed in the `/views` folder and are available in the `app.views` object.

Neft uses various custom attributes and tags. All prefixed by the `neft:`.

## String interpolation

```html
${…}
```

String interpolation is used in texts and in the tag attributes.

If the resource object is a Dict, updates are synchronized.
For `Dict`s, there is no need to use the `Dict::get()` function.

By default, views are rendered with the route object as globals.

```javascript
// routes/user.js
module.exports = (app) => {
    return {
        'get /user': {
            showAge: true,
            getData(callback) {
                callback(null, { login: 'Johny', age: 25 });
            }
        }
    };
};
```
```html
<!-- views/user.html -->
<h1>Hi ${root.data.login}</h1>
<h2 neft:if="${root.showAge}">Your age: ${root.data.age}</h2>
```

## Condition

`neft:if` changes tag visibility based on the condition.

`neft:else` is optional and must be a next sibling of a tag with condition.

```html
<div neft:if="${props.a > props.b}">a is greater than b</div>
<div neft:else>a isn't greater than b</div>
```

## Iterators

`neft:each` repeats his body for the each element of the given array.

Automatically synchronizes with the given List instance.

Creates three global properties available in the `neft:each` body: `i`, `item` and `each`.

```html
<ul neft:each="[1, 2, 3]">
    <li>Index=${props.index}; element=${props.item}; array=${props.each}</li>
</ul>
```

## Fragments

`neft:fragment` is a template for repeated pieces of code.

Fragment can be rendered by the `neft:use` tag.

```html
<neft:fragment neft:name="avatar">
    <!-- user avatar view -->
</neft:fragment>

<use:avatar />
```

### String interpolation

`neft:fragment` attributes works as the most important globals for the string interpolation, then `neft:use` attributes and finally the route object.

```html
<neft:fragment neft:name="avatar" showLogin="true">
    <h5 neft:if="${props.showLogin}">${props.user.login}</h5>
</neft:fragment>

<use:avatar user="${root.data.user}" />
```

## Identifiers

Tags with the `id` attribute are available in the string interpolation as globals.

```html
<input type="text" id="userNameInput" value="Max" />
<h1>Your name: ${ids.userNameInput.attrs.value}</h1>
```

## Logging

For the debug purposes you can use the `neft:log` tag.

```html
<neft:log userData="${props.data}">${props.text}</neft:log>
```

## More tags

Only the basic special attributes and tags have been described here.
Check later the API Reference for more.

## Route integration

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

Described `toHTML` syntax is a simplification but sufficient for more cases.
`toHTML` can be also a normal function which will render the view using the Document module API.

Next article: [[Styles - Tour]]
