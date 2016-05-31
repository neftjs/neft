> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

RotationSensor
<dl><dt>Syntax</dt><dd><code>RotationSensor @namespace</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#rotationsensor)

RotationSensor
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; RotationSensor</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
```nml
`RotationSensor.active = true;
`
`Text {
`   font.pixelSize: 30
`   onUpdate: function(){
`       this.text = "x: " + RotationSensor.x + "; " +
`           "y: " + RotationSensor.y + "; " +
`           "z: " + RotationSensor.z;
`   }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#rotationsensor)

active
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor::active = false</code></dd><dt>Prototype property of</dt><dd><i>RotationSensor</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#active)

x
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor::x = 0</code></dd><dt>Prototype property of</dt><dd><i>RotationSensor</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#x)
