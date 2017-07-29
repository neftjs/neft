# Stringifying

> **API Reference** ▸ [Utils](/api/utils.md) ▸ **Stringifying**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/810d632b749dd90b1cb627d0dade7eb96524f959/src/utils/stringifying.litcoffee)


* * * 

### `utils.simplify()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Object</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd></dl>

Convert the given object into the most simplified format with no cyclic references and more.

Such object can be easily stringified later using standard *JSON.stringify()*.

Use utils.assemble() function to restore the object into the initial structure.

Second parameter is an config object (all 'false' by default):
  - *properties* - save properties descriptors (getters, config etc.),
  - *protos* - save protos as objects,
  - *constructors* - include constructor functions.

```javascript
var obj = {};
obj.self = obj;
console.log(JSON.stringify(utils.simplify(obj)));
```

If *protos* is *false* and *constructors* is *true*,
object will be recognized as an instance.

```javascript
function Sample(){
  this.fromInstance = 1;
}
Sample.prototype.fromPrototype = 1;

var sample = new Sample;
var parts = utils.simplify(sample, {constructors: true});
var clone = utils.assemble(json);

console.log(clone instanceof Sample)
// it's true because 'protos' option is false and 'constructors' is true
// won't work for json, because functions are not stringified ...
```


> [`Source`](https://github.com/Neft-io/neft/blob/810d632b749dd90b1cb627d0dade7eb96524f959/src/utils/stringifying.litcoffee#utilssimplifyobject-object-object-options)


* * * 

### `utils.assemble()`

<dl><dt>Static method of</dt><dd><i>utils</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>PlainObject</i></li></ul></dd></dl>

Backward utils.simplify() operation.


> [`Source`](https://github.com/Neft-io/neft/blob/810d632b749dd90b1cb627d0dade7eb96524f959/src/utils/stringifying.litcoffee#utilsassembleplainobject-object)

