# Data Binding

From previous articles, you learned that Neft has three places, where you can handle your data:

1. [Routing](/routing.md),
2. [Views](/views.md),
3. [Styles](/styles.md).

Each place is different and built for specified use-cases.

Data originally comes from [routes](/routing.md) and is propagated through [views](/views.md) to [styles](/styles.md).

Neft supports automatic updates, when you change data. It's called *data binding*.

For instance, in a [route](/routing.md) you created a [list](/api/list.html) of records. Such list is rendered by one of your views. If you want to add another record, you just do it in a route, and views are automatically refreshed.

You need to remember, that such list need to be a [Neft.List](/api/list.html). Standard arrays are not supported, and your change won't be propagated.

To better understand how to use it, let's start from the beginning...

## [Signals](/api/signal.html)

[Signal](/api/signal.html) is a function.

You can connect to it (listen on signals) and disconnect.

It can be emitted with parameters.

It's used in various Neft modules to support automatically data-binding.
In most cases there is no need to create them manually.

```javascript
const { signal } = Neft;
const onLoad = signal.create();
onLoad.connect((src) => console.log(`LOADED: ${src}`));
onLoad.emit('/logo.png');
// LOADED: /logo.png
```

Similar to *events model* well-known in other frameworks.

Do you remember that *Signal* is a function? It works like `connect`.

Both lines do the same:

```javascript
onLoad.connect((src) => console.log(`LOADED: ${src}`));
onLoad((src) => console.log(`LOADED: ${src}`));
```

If you want to stop listening on a changes, call `disconnect` with registered listener.

```javascript
const { signal } = Neft;
const onLoad = signal.create();
const logSrc = (src) => console.log(`LOADED: ${src}`);
onLoad(logSrc);
onLoad.disconnect(logSrc);
onLoad.emit('/logo.png'); // does nothing
```

Signals have a limit. You can emit up to two parameters in one call. The workaround is to emit an object.

Now you know how Neft propagates changes. Let's see how we can you this knowledge.

### [List](/api/list.html)

[List](/api/list.html) is an observable version of standard arrays.

To create a list, call [its constructor](/api/list.html#constructor):

```javascript
const { List } = Neft;
new List(); // empty list
new List([1, 2]); // list with two values: 1 and 2
List(); // *new* is optional
```

Data in a list can be modified. Basic methods are: [`append()`](/api/list.html#append), [`set()`](/api/list.html#set), [`insert()`](/api/list.html#insert) and [`pop()`](/api/list.html#pop).

```javascript
const { List } = Neft;
const data = new List;

data.append('tree');
data.insert(0, 'house');
console.log(data[0]); // house
console.log(data[1]); // tree
console.log(data.length); // 2

data.pop();
console.log(data.length); // 1

data.set(0, 'ketchup');
console.log(data[0]); // ketchup
```

Each change in a list calls different [signals](/api/signal.html):
 - [`onChange`](/api/list/html#onchange) called when some value change,
 - [`onInsert`](/api/list/html#oninsert) called with added value,
 - [`onPop`](/api/list/html#onpop) called with removed value.

```javascript
const { List } = Neft;
const data = new List;

data.append('fries');
data.onPop((oldValue, index) => console.log(`${oldValue} has been removed`));

data.pop();
// fries has been removed
```

## [Dict](/api/dict.html)

[Dict](/api/dict.html) is an observable version of standard objects.

To create a dict, call [its constructor](/api/dict.html#constructor):

```javascript
const { Dict } = Neft;
new Dict(); // empty dict
new Dict({ name: 'Johny' }); // dict with one key
Dict(); // *new* is optional
```

Data in a dict can be changed using the [`set()` method](/api/dict.html#set).

```javascript
const { Dict } = Neft;
const data = new Dict;

data.set('pet', 'cat');
console.log(data.pet); // cat
```

Each change in a dict emits [`onChange` signal](/api/dict.html#onchange).

```javascript
const { Dict } = Neft;
const data = new Dict;

data.onChange((key, oldValue) => console.log(`${key} now is equal ${data[key]}`));
data.set('pet', 'cat');
// pet now is equal cat
```
