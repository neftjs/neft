# Native

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Native**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee)


* * * 

### `Native.New()`

<dl><dt>Static method of</dt><dd><i>Native</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Native</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee#native-nativenewcomponent-component-object-options)


* * * 

### `Native.defineProperty()`

<dl><dt>Static method of</dt><dd><i>Native</i></dd><dt>Parameters</dt><dd><ul><li>config — <i>Object</i></li></ul></dd></dl>

Defines new property with the given name.

For each property, signal `onXYZChange` is created,
where `XYZ` is the given name.

`config` parameter must be an object with specified keys:
- `enabled` - whether it's supported on current platform,
- `name` - name of the property,
- `type` - type of predefined condifuration described below,
- `defaultValue`,
- `setter`,
- `getter`,
- `developmentSetter`
- `implementationValue` - function returning value passed to the implementation.

### Predefined types


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee)

#### text


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee)

#### number


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee)

#### boolean


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee)

#### color


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee)

#### item


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Native</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee#native-nativeconstructor--item)


* * * 

### `set()`

<dl><dt>Parameters</dt><dd><ul><li>propName — <i>String</i></li><li>val — <i>Any</i></li></ul></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee#nativesetstring-propname-any-val)


* * * 

### `call()`

<dl><dt>Parameters</dt><dd><ul><li>funcName — <i>String</i></li><li>args... — <i>Any</i></li></ul></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee#nativecallstring-funcname-any-args)


* * * 

### `on()`

<dl><dt>Parameters</dt><dd><ul><li>eventName — <i>String</i></li><li>listener — <i>Function</i></li></ul></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/native.litcoffee#nativeonstring-eventname-function-listener)

