> [Wiki](Home) ▸ [API Reference](API-Reference)

RotationSensor
<dl><dt>Syntax</dt><dd>RotationSensor @namespace</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/sensor/rotation.litcoffee#rotationsensor-namespace)

RotationSensor
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) RotationSensor</dd><dt>Type</dt><dd><i>Object</i></dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/sensor/rotation.litcoffee#object-rotationsensor)

active
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) RotationSensor::active = false</dd><dt>Prototype property of</dt><dd><i>RotationSensor</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/sensor/rotation.litcoffee#float-rotationsensoractive--false)

x
<dl><dt>Syntax</dt><dd>[*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) RotationSensor::x = 0</dd><dt>Prototype property of</dt><dd><i>RotationSensor</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/namespace/sensor/rotation.litcoffee#float-rotationsensorx--0float-rotationsensory--0float-rotationsensorz--0)

