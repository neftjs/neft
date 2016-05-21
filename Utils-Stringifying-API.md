> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Stringifying**

# Stringifying

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/stringifying.litcoffee#stringifying)

## Table of contents
* [Stringifying](#stringifying)
  * [simplify](#simplify)
  * [assemble](#assemble)

##simplify
<dl><dt>Syntax</dt><dd><code>simplify(&#x2A;Object&#x2A; object, [&#x2A;Object&#x2A; options])</code></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/stringifying.litcoffee#simplify)

##assemble
<dl><dt>Syntax</dt><dd><code>assemble(&#x2A;PlainObject&#x2A; object)</code></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isplainobject">PlainObject</a></li></ul></dd></dl>
Backward utils.simplify() operation.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/utils/stringifying.litcoffee#assemble)

