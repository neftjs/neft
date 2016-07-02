> [Wiki](Home) ▸ [[Tour]] ▸ **Data Binding**

Data Binding
===

Signals
---

Signal is a function works similarly to the common events pattern.

It's used in various Neft modules to support automatically data-binding and in more cases there is no need to create them manually.

```javascript
const { signal } = Neft;

const onLoad = signal.create();
onLoad((src) => console.log(src));
onLoad.emit('/logo.png'); // logs '/logo.png'
```

Mutable data
---

Neft supports data-binding between routes, views and styles.
To ensure this goal, Neft uses observable versions of objects and arrays.

### Dict

This observable version of the JavaScript Object, emits `onChange` signals.
Data can be changed using the `set()` method.

```javascript
const { Dict } = Neft;

const data = new Dict;
data.set('pet', 'cat'); // will emit the onChange signal
data.pet; // cat
```

### List

This observable version of the JavaScript Array, emits `onChange`, `onInsert` and `onPop` signals.
Data can be changed using different various methods (e.g. `append()`, `insert()`, `pop()` and more).

```javascript
const { List } = Neft;

const data = new List;
data.append('tree');
data.insert(0, 'house');
data[0]; // house
data.pop();
data.length; // 1
```

Next article: [[Routing - Tour]]
