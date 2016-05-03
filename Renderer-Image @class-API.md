Image @class
============

```nml
`Image {
`   source: 'http://lorempixel.com/200/140/'
`   onLoad: function(error){
`       if (error){
`           console.error("Can't load this image");
`       } else {
`           console.log("Image has been loaded");
`       }
`   }
`}
```

*Image* Image.New([*Component* component, *Object* options])
------------------------------------------------------------

*Image* Image() : *Renderer.Item*
---------------------------------

*Float* Image.pixelRatio = 1
----------------------------

## *Signal* Image.onPixelRatioChange(*Float* oldValue)

*Float* Image::width = -1
-------------------------

*Float* Image::height = -1
--------------------------

*String* Image::source
----------------------

The image source URL or data URI.

## *Signal* Image::onSourceChange(*String* oldValue)

ReadOnly *Float* Image::resolution = 1
--------------------------------------

Hidden *Float* Image::sourceWidth = 0
-------------------------------------

## Hidden *Signal* Image::onSourceWidthChange(*Float* oldValue)

Hidden *Float* Image::sourceHeight = 0
--------------------------------------

## Hidden *Signal* Image::onSourceHeightChange(*Float* oldValue)

Hidden *Float* Image::offsetX = 0
---------------------------------

## Hidden *Signal* Image::onOffsetXChange(*Float* oldValue)

Hidden *Float* Image::offsetY = 0
---------------------------------

## Hidden *Signal* Image::onOffsetYChange(*Float* oldValue)

Hidden *Integer* Image::fillMode = 'Stretch'
--------------------------------------------

## Hidden *Signal* Image::onFillModeChange(*Integer* oldValue)

ReadOnly *Boolean* Image::loaded
--------------------------------

## *Signal* Image::onLoadedChange(*Boolean* oldValue)

*Signal* Image::onLoad()
------------------------

*Signal* Image::onError(*Error* error)
--------------------------------------

