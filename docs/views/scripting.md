# Scripting

Each view file and [component](/views.html#component) can be scripted.

The whole *JavaScript* code put inside the `<script />` tag.

In the view file:

```xhtml
<script></script>
```

or in a [component](/views.html#component):

```xhtml
<component name="Avatar">
    <script></script>
</component>
```

## View lifecycle

Inside the `<sript />` tag you can connect to four [signals](/data-binding.html#signal):
 - `this.onBeforeRender()`,
 - `this.onRender()`,
 - `this.onBeforeRevert()`,
 - `this.onRevert()`.

View once created is reusing. Because of that, `<script>` is called only when there is no free views to use and a new one has to be created.

When a view needs to be put into a document, it's **rendered** (`onBeforeRender`, `onRender`).

When a view is no longer needed, it's **reverted** (`onBeforeRevert`, `onRevert`).

Reverted views can be rendered later.

## Custom methods

Custom methods should be created inside the `<script>` tag as lambda functions.

It ensures, that you have always the proper context (`this`) inside all methods.

View context can be used in [String Interpolation](/views.html#string-interpolation).

```xhtml
<p>${this.plusOne(2)}</p> <!-- <p>3</p> -->

<script>
this.plusOne = (number) => {
    return number + 1;
};
</script>
```

## `this.state`

`this.state` is a [Dict](/data-binding.html#dict).
Use it to store custom data for a rendered view.

It's save to use. Automatically cleared when view is *reverted*.

Data can be read in [String Interpolation](/views.html#string-interpolation) under the `${state}` object.

Default `state` must be defined in `onBeforeRender` signal.

```xhtml
<p>Counter: ${state.counterValue}</p> <!-- <p>Counter: 2</p> -->

<script>
this.increment = () => {
    this.state.set('counterValue', this.state.counterValue + 1);
};

this.onBeforeRender(function () {
    this.state.set('counterValue', 1);
    this.increment();
});
</script>
```

## `this.refs`

All nodes with [`ref`](/views.html#ref) tags are available under the `this.refs` object.

```xhtml
<script>
this.onRender(function () {
    this.refs.image.props.set('src', "rsc:background");
});
</script>
<img ref="image" /> <!-- <img src="rsc:background" /> -->
```

If node with `ref` tag renders a [component](/views.html#component), it refers to the `this` context and not no the [Virtual DOM](/views/virtual-dom.html) element.

```xhtml
<component name="Issue">
    <script>
    this.getTitle = () => 'More gifs!';
    </script>
</component>

<component name="IssueList">
    <script>
    this.onRender(function () {
        console.log(this.refs.firstIssue.getTitle());
        // More gifs!
    });
    </script>
    <Issue ref="firstIssue" />
</component>

<IssueList />
```

This object is available in [String Interpolation](/views.html#string-interpolation) as `${refs}`.

## `this.node`

It refers to the main view or component [element](/views/virtual-dom.html).

More about it you'll learn in the [next chapter](/views/virtual-dom.html) but you can use it to e.g. find an element by a selector.

```xhtml
<script>
this.onBeforeRender(function () {
    const spans = this.node.queryAll('p > span');
    console.log(spans);
    // [<span>first</span>, <span>third</span>]
});
</script>
<p><span>first</span> second <span>third</span></p>
```

## `this.props`

`this.props` object contains properties used to create a [component](/views.html#component).

You should not change it.

Use it to configure creating components.

This object is available in [String Interpolation](/views.html#string-interpolation) as `${props}`.

```xhtml
<component name="User">
    <script>
    this.onRender(function () {
        console.log(this.props.nick);
        // testslover32
    });
    </script>

    <h1>${props.nick}</h1>
</component>

<User nick="testslover32" />
```

`this.props` is an instance of [Dict](/data-binding.html#dict) and can be changed in runtime. Connect to [`this.props.onChange()`](/api/dict.html#onchange) signal if you want to detect it manually.

## `this.context`

This property refers to a [route](/routing.html) used to render this view.

You can use to make, for instance, a *HTTP* request.

```xhtml
<script>
this.onBeforeRender(function () {
    this.context.app.networking.get('/users', (err, resp) => {});
});
</script>
```

... or to get a [route.data](/api/app-route.html#data).

More about it you'll learn in [Routing](/routing.html) chapter.

This object is available in [String Interpolation](/views.html#string-interpolation) as `${context}`.

## Script file

You can move your *JavaScript* code to separated file.

`<script />` accepts `src` attribute. Use is with relative path.

```xhtml
<script src="./scriptFile.js" />
```

## CoffeeScript support

If you like to use *CoffeeScript*, you can do it by specifying the `filename` attribute with the *.coffee* extension.

```html
<script filename="view.coffee">
@sum = (a, b) => a + b
</script>
```
