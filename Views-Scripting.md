`${this}` is available in each view file and `<neft:fragment />`. These objects are not shared between different views or fragments so can be easily used to extend HTML by custom JavaScript methods.

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

## Extending object

To modify the `this` object, create a `<neft:script>` or `<script>` tag.

The given JavaScript code has access to the `this` object and can easily modify it, adding new methods or listening on signals.

In the example below we add simple `sum` function into the context. Created function can be used in string interpolated texts.

```html
<script>
    this.sum = function (a, b) { return a + b };
</script>
<h1>1 + 2 = ${this.sum(1, 2)}</h1>
```

## View lifecycle

Created views are not removing from the memory. They are clearing and reusing again.

To have control of the current view status, you can listen on various `this` signals:

 - `this.onCreate()`,
 - `this.onBeforeRender()`,
 - `this.onRender()`,
 - `this.onBeforeRevert()`,
 - `this.onRevert()`.

You can't use EcmaScript 6 arrow functions to listen on these signals, because they are calling with modified `this` context.

### onCreate

`this.onCreate()` is called when the view is cloned. Inside this handler, data set into the `this` object is not shared between different instances of the same view but it's not cleared after the view reverting.

It can be used to e.g. register listeners.

```html
<script>
    this.onCreate(function () {
        this.ids.input.onAttrsChange((attr, value) => console.log(attr, value));
    });
</script>
<input type="text" id="input" />
```

### onRender

`this.onRender()` signal is called when the view instance is ready to be used. From this point you have access to the `this.state` object.

```html
<script>
    this.onRender(function () {
        this.state.extend({ counter: 0 });
    });
</script>
<h1>Counter: ${this.state.counter}</h1>
```

### onRevert

Use `this.onRevert()` signal to clear your view and prepare it for the further rendering.

## Predefined properties

`this` context object contains some predefined properties:

 - `this.props` - attributes from `<neft:use />`,
 - `this.ids` - all view elements with defined `id` attribute,
 - `this.root` - route object,
 - `this.node` - main view Virtual DOM element.

## Script files

If our JavaScript code inside the `<script>` tag is really long, you can move it to separated file - just include the relative `src` attribute.

```html
<script src="./customFile.js" />
```

## CoffeeScript support

If you like to use CoffeeScript in views as well, you can do it by specifying the `filename` attribute with *.coffee* extension.

```html
<script filename="view.coffee">
    @sum = (a, b) -> a + b
</script>
```
