Screen @namespace
=================

*Object* Screen
---------------

ReadOnly *Boolean* Screen.touch = false
---------------------------------------

```nml
`Text {
`   text: Screen.touch ? "Touch" : "Mouse"
`   font.pixelSize: 30
`}
```

ReadOnly *Float* Screen.width = 1024
------------------------------------

ReadOnly *Float* Screen.height = 800
------------------------------------

ReadOnly *String* Screen.orientation = 'Portrait'
-------------------------------------------------

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape

## *Signal* Screen.onOrientationChange(*String* oldValue)

