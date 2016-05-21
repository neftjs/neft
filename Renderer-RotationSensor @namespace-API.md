> [Wiki](Home) ▸ [API Reference](API-Reference)

RotationSensor
<dl><dt>Syntax</dt><dd><code>RotationSensor @namespace</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#rotationsensor-namespace)

RotationSensor
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; RotationSensor</code></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#object-rotationsensor)

active
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor::active = false</code></dd><dt>Prototype property of</dt><dd><i>RotationSensor</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#float-rotationsensoractive--false)

x
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; RotationSensor::x = 0</code></dd><dt>Prototype property of</dt><dd><i>RotationSensor</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/namespace/sensor/rotation.litcoffee#float-rotationsensorx--0float-rotationsensory--0float-rotationsensorz--0)

