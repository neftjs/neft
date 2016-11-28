# Views

Views on the client side are used to position, organize and handle rendered elements.

Views can be also used to serve HTML documents for crawlers (e.g. GoogleBot).

All views must be placed in the `/views` folder and are available in the `app.views` object.

`views/index.html` view is rendered by default.

## View file

Each view placed in the `/views` folder must be a *HTML* file.

Neft uses various custom XML attributes and tags. All prefixed by `neft:` (tags) or `n-` (attributes).

All elements inside the `<body>` tag are rendered by default.

## String interpolation

```html
${…}
```

String interpolation can be used in texts and in attribute values.

You have access to some global objects:
 - `this` - locally scoped object easily extended by `<script>` tags,
 - `context`/`this.context` - a route or special object for template views,
 - `props`/`this.props` - attributes from `<neft:use>` available in `<neft:fragment>`,
 - `state`/`this.state` - Dict used to store local data,
 - `refs`/`this.refs` - all local nodes under their `ref`s,
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

## References

Tags with the `ref` attribute is available in the `refs`/`this.refs` object.

```html
<input type="text" ref="userNameInput" value="Max" />
<h1>Your name: ${refs.userNameInput.props.value}</h1>
```

## Logging

For the debug purposes you can use the `<neft:log>` tag.

```html
<neft:log userData="${props.data}">${props.text}</neft:log>
```
