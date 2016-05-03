RotationSensor @namespace
=========================

*Object* RotationSensor
-----------------------

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

*Float* RotationSensor::active = false
--------------------------------------

*Float* RotationSensor::x = 0
-----------------------------

*Float* RotationSensor::y = 0
-----------------------------

*Float* RotationSensor::z = 0
-----------------------------

