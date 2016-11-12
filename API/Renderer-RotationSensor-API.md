> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **RotationSensor**

# RotationSensor

```javascript
`
RotationSensor.active = true;
`
Text {
    font.pixelSize: 30
    onUpdate: function(){
    this.text = 'x: ' + RotationSensor.x + '; ' +
        'y: ' + RotationSensor.y + '; ' +
        'z: ' + RotationSensor.z;
    }
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/sensor/rotation.litcoffee)

## Table of contents
* [RotationSensor](#rotationsensor)
  * [active](#active)
  * [x](#x)
  * [y](#y)
  * [z](#z)
* [Glossary](#glossary)

##active
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor.active = `false`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-RotationSensor-API#rotationsensor">RotationSensor</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/sensor/rotation.litcoffee#float-rotationsensoractive--false)

##x
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor.x = `0`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-RotationSensor-API#rotationsensor">RotationSensor</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##y
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor.y = `0`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-RotationSensor-API#rotationsensor">RotationSensor</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##z
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor.z = `0`</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-RotationSensor-API#rotationsensor">RotationSensor</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/namespace/sensor/rotation.litcoffee#float-rotationsensorz--0)

# Glossary

- [RotationSensor](#rotationsensor)

