Navigator @namespace
====================

*Object* Navigator
------------------

*Boolean* Navigator.language = 'en'
-----------------------------------

```nml
`Text {
`   text: "Your language: " + Navigator.language
`   font.pixelSize: 30
`}
```

*Boolean* Navigator.browser = true
----------------------------------

*Boolean* Navigator.native = false
----------------------------------

```style
`Text {
`   text: Navigator.native ? "Native" : "Browser"
`   font.pixelSize: 30
`}
```

*Boolean* Navigator.online = true
---------------------------------

## *Signal* Navigator.onOnlineChange(*Boolean* oldValue)

