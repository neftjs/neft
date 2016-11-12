Views are used to serve HTML documents for crawlers (e.g. GoogleBot), browsers with no JavaScript support and, on the client side, to position and handle rendered elements.

In Neft, all views must be placed in the `/views` folder and are available in the `app.views` object.

Neft uses various custom attributes and tags. All prefixed by `neft:`.

## Route integration

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

## String interpolation

```html
${…}
```

String interpolation is used in texts and in tag attributes.

If the object is a Dict, List or any other object providing signals, the string interpolated text is automatically updated.

You have access to some global objects:
 - `this` - locally scoped object easily extended by `<script>` tags,
 - `root`/`this.root` - a route or special object for template views,
 - `props`/`this.props` - attributes from `<neft:use>` available in `<neft:fragment>`,
 - `state`/`this.state` - Dict used to store local data,
 - `ids`/`this.ids` - all local nodes under their `id`s,
 - `this.node` - current `<neft:fragment>` Virtual DOM node.

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

`neft:if` changes the tag visibility based on the condition.

`neft:else` is optional and must be placed in the next sibling of a tag with condition.

```html
<div neft:if="${props.a > props.b}">a is greater than b</div>
<div neft:else>a isn't greater than b</div>
```

## Iterators

`neft:each` repeats his body for the each element of the given array.

Automatically synchronizes with the given List instance.

Creates three global properties available in the `neft:each` body: `props.index`, `props.item` and `props.each`.

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

<neft:use neft:fragment="avatar" />
<!-- or just -->
<use:avatar />
```

## Identifiers

Tags with the `id` attribute is available in the `ids`/`this.ids` object.

```html
<input type="text" id="userNameInput" value="Max" />
<h1>Your name: ${ids.userNameInput.attrs.value}</h1>
```

## Logging

For the debug purposes you can use the `<neft:log>` tag.

```html
<neft:log userData="${props.data}">${props.text}</neft:log>
```

## Script

`<neft:script>` or just `<script>` is called with the `this` object used in string interpolation.

```html
<script>
    this.sum = (x, y) => x + y;
</script>
<h1>${this.sum(1, 2)}</h1>
```

You can also use external file by the `<neft:script src="" />` attribute.

## Fragment lifecycle

Created `<neft:fragment>`s are reusing and keeping in the memory to ensure the best performance.

`<script>` `this` object contains some signals used to detect the fragment status.

```html
<script>
    this.onCreate(function() {});
    this.onBeforeRender(function() {});
    this.onRender(function() {});
    this.onBeforeRevert(function() {});
    this.onRevert(function() {});
</script>
```

After `onCreate` you will only get looped render and revert signals.

Because the `this` object is shared between rendered fragments, you should always use the `this.state` Dict to store the local data. You can be sure, that this object is empty when the fragment is rendered.

```html
<script>
    this.onRender(function() {
        this.state.extend({ x: 1 });
    });
</script>
<h1>${state.x}</h1>
```

## More tags

Only the basic special attributes and tags have been described here.
Check later the API Reference for more.

Next article: [[Styles - Tour]]