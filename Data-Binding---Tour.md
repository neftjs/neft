> [Wiki](Home) ▸ [[Tour]] ▸ **Data Binding**

Data Binding
===

Mutable data
---

Neft supports data-binding between routes, views and styles.
To ensure this goal, Neft uses observable versions of objects and arrays.

### Dict

This observable version of the JavaScript Object, emits `onChange` signals.
Data can be accessed by the `get()` method and changed using the `set()` method.

```javascript
var Dict = require('dict');

var data = new Dict;
data.set('pet', 'cat');
data.get('pet'); // cat
```

### List

This observable version of the JavaScript Array, emits `onChange`, `onInsert` and `onPop` signals.
Data can be accessed by the `get()` method and changed using different various methods (e.g. `append()`).

```javascript
var List = require('list');

var data = new List;
data.append('tree');
data.insert(0, 'house');
data.get(0); // house
data.pop();
data.length; // 1
```

Signals
---

Signal is a function works similarly to the common events pattern.

```javascript
var signal = require('signal');

var onLoad = signal.create();
onLoad(function(src){
    console.log(src);
});
onLoad.emit('/logo.png');
```

Signals are used in various Neft modules.

```javascript
var Dict = require('dict');

var data = new Dict;
data.onChange(function(key, oldValue){
    console.log("Key " + key + " has been changed; was " + oldValue + ", now is" + this.get(key));
});
data.set('pet', 'squirrel');
```

Next article: [[Routing - Tour]]
