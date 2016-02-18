# Changelog

*Neft is in beta. All stupidness are treated as bugs.*

## 0.9.12 - Bugs fixes
### Renderer
- [Class now uses document.query priority instead of commands length](https://github.com/Neft-io/renderer/commit/47edc96f40313a251532b5aa758b9ad53430fc97)
- [Fixed properties <-> node attrs synch cleaning](https://github.com/Neft-io/renderer/commit/2ae80fe4cb9229a378af0a76565d88ca11e57501)
- [Better Flow loops detected](https://github.com/Neft-io/renderer/commit/a98d736260fdae16af3f4f9b534d9efcfc3a7b3f)
- [Fixed bugs with properties <-> node attributes synchronization](https://github.com/Neft-io/renderer/commit/e9ed10f0587c94a4424adbdc6d482a6b01855188)
- [Flow/Grid now updates on runtime padding change](https://github.com/Neft-io/renderer/commit/3caea11a855036105f33636bb76231bbf7f55609)
- [Item::children now is not an array; use linked list](https://github.com/Neft-io/renderer/commit/d0fcf015df2f52e12aeb98793512a7dd0c5b9371)
- [Pointer bug with events propagation fixed](https://github.com/Neft-io/renderer/commit/a5fbc32c36d0c9bbbd0e1562df246e8b46155135)
- [Item::children::topChild/bottomChild z indexes linked list added](https://github.com/Neft-io/renderer/commit/5bd05d587e1ccbafb2a9dc7e5e66de52fa65a26c)
- [Classes with custom targets now are supported](https://github.com/Neft-io/renderer/commit/75d15343e1da00bf991c21257000b3c8443486ff)

### Styles
- [Better synchronization for nodes with no previous siblings](https://github.com/Neft-io/styles/commit/b2dd4a49f75a553e7cddbc18ef07d4e40b88d789)

### Schema
- [Optional properties now are omitted if don't exist](https://github.com/Neft-io/schema/commit/8a7dd64f0d5baeb4181bde6578440bb2ca2a608d)

### Document
- [Element.Tag.query.getSelectorPriority() added](https://github.com/Neft-io/document/commit/f124f4cbe8d75fb863e13d2e7aa876a057f9d1a1)
- [Tag::watch() bug with finding updates from 'watch()' signals fixed](https://github.com/Neft-io/document/commit/c01b328f9e9a81f99bd012ddcd0cf1cec4b3b3c5)

### Networking
- [Uri::match() now always returns an object](https://github.com/Neft-io/networking/commit/1bf273829d8b011df4f845b29647bfe0312bcece)
- [createRequest() now accepts a Request instance](https://github.com/Neft-io/networking/commit/493009d90fa0c2eb16f946d9c54b4da796e5bea6)

## 0.9.11 - Bugs fixes
### Neft-CLI
- [New 'local.android' compile properties added](https://github.com/Neft-io/neft-cli/commit/be96fe4c3fbf13af5bc87514e6f657af8b1124fb)

## 0.9.7 - Bugs fixes
### Log
- ['enabled' now works for scoped log instances](https://github.com/Neft-io/log/commit/675280f800fc8a460cad8565f1be2c27c92a4117)

## 0.9.4 - Bugs fixes
### Renderer
- [CSS TextInput focus management fixed](https://github.com/Neft-io/renderer/commit/4e7ebcd428c9b69a772c8d1e57dce463e458e214)

### Styles
- [Finding style index while document synchronisation bugs fixed](https://github.com/Neft-io/styles/commit/052a278d0ac05339e433dcf8ca0dea02e7fbda44)
- [Item visibility management fixed](https://github.com/Neft-io/styles/commit/da65272a12b5106084af5f42c0ca61bf282abccd)

## 0.9.3 - Bugs fixes
### Neft-CLI
- [Applying style queries through neft:fragment/neft:each bug fixed](https://github.com/Neft-io/neft-cli/commit/0733b4ccfeb0e9178f53eaa95ca9f388dafb3b28)
- ['Neft' object now is global on Node](https://github.com/Neft-io/neft-cli/commit/42a9414cffb0d8d30cc5da1bc0ed5709adffeb3d)
- [App 'package.json' 'styles' object may contains paths for external styles](https://github.com/Neft-io/neft-cli/commit/a0b3d6c80d4f19403a19aecf7aa9adb90a92aa1d)

### Renderer
- [CSS TextInput 'password' echoMode positioning bug fixed](https://github.com/Neft-io/renderer/commit/148e50de6d0cc51278e714f39b83848b3e4e3386)

### Styles
- [Unsynchronized tags now are not rendered](https://github.com/Neft-io/styles/commit/ce526f459d6e4e3d5eaed200379a54c734c74944)

### Document
- [Texts clearing right trim bug fixed](https://github.com/Neft-io/document/commit/e7ea4ec810a01bfa3fb7133f7439c0311fd5134d)
- [String interpolation listening changes on global object fixed](https://github.com/Neft-io/document/commit/3f4eb236a680bf6161507e98298e6fcbc0adeb5a)
- [Tag::watch() bug with omitting changes on the main tag fixed](https://github.com/Neft-io/document/commit/fb4d7eab7b2712cd4f93547140f2725359b87517)
- [Tag::query() now uses javascript values for string booleans,null,undefined in comparison](https://github.com/Neft-io/document/commit/2866069884c1d5eedbc2346908b23ce702612c44)

### Networking:
- [Client impls now longer add styles into window](https://github.com/Neft-io/networking/commit/2ed1df853643b57be11e9c904e3fd31a4a3297a5)

## 0.9.2 - Bugs fixes
### Bundle builder
- ['release' mode bug with removing vars declarations fixed](https://github.com/Neft-io/bundle-builder/commit/beb90f970a8373e2cb4e6630dbece9fec275acd8)

### Renderer
- [Bug with trying to watch text elements fixed](https://github.com/Neft-io/renderer/commit/a58191573d00f1c2a1dd879b471fd9259f0b223a)

### Styles
- [Text now are not set if tag contains styled children](https://github.com/Neft-io/styles/commit/2005a5c698333a51c21f8828c108d9ca4c2344f4)

## 0.9.1 - Bugs fixes
### Renderer
- [CSS Scrollable minus contentX bug fixed](https://github.com/Neft-io/renderer/commit/2e6c374d6d074f54e6afb48d0bad23a6afd2babe)
- [Default Text and TextInput font weight fixed](https://github.com/Neft-io/renderer/commit/390bb20f44544eb586b30d5d2a44f65ac08f52ff)

### Document:
- [File clearing improved: texts now are properly trimmed](https://github.com/Neft-io/document/commit/9f1190e5d17892cc2c252b2cbfc9caaa0d15d55e)
- ['neft:target' rendering bug fixed](https://github.com/Neft-io/document/commit/c80e7225c29b1e1a321010d29d2129ece9eb0447)
- [Parsed attrs now are properly stringified and cloning](https://github.com/Neft-io/document/commit/4b0a32c27b16b7ad30791d17a05b1d130d6e8e99)
- [Tag::*Attr changed to Tag::attrs::*](https://github.com/Neft-io/document/commit/e456a28f4f08903301286a5b406a5c9fb04fc332)

### Styles:
- [Finding indexes for Text elements fixed](https://github.com/Neft-io/styles/commit/3de5b28b231879e23752222c6979fc1dc05102d7)
- [Text element visible synchronization fixed](https://github.com/Neft-io/styles/commit/4666a8305960940bb1e768695867799f93609ebd)

## 0.9.0 - New features
### Styles
- [Text elements now are rendered as Text items](https://github.com/Neft-io/styles/commit/573da994f915ceaafed8244ec939475ec3efa5af)

## 0.8.27 - Bugs fixes
### Renderer
- [Image::resolution added; retina images sizes now are properly recognized](https://github.com/Neft-io/renderer/commit/8cc24a60aaafa4f22d0db599f5c452410cdfb948)
- [Test item with no children in the abstract pointer impl fixed](https://github.com/Neft-io/renderer/commit/c1eab4729c8c17aa938dd06c650d418b049bc6f2)
- [CSS Text impl: bug with adding css styles fixed](https://github.com/Neft-io/renderer/commit/1b2f2de9e0760a27eafbc890eb33ba40e5acc932)
- [Detecting font load in CSS impl improved](https://github.com/Neft-io/renderer/commit/da27c2fc422db217c01e11b9a2c3651369904cdd)
- [Cloning class children bug fixed](https://github.com/Neft-io/renderer/commit/0db40b3a5e07352c383daba81e3fad3989dc5975)

### Neft-CLI
- ['sharp' module now must be a local module](https://github.com/Neft-io/neft-cli/commit/88384a4656ff9e8fb99b8d6b44c85db03317567e)

## 0.8.26 - Bugs fixes
### Bundle builder
- [Bundle file is no longer wrapped in 'use strict'](https://github.com/Neft-io/bundle-builder/commit/c55cf75b784fe9d008a1cfa9326105e340b9f407)

### Document
- [Setting tag attributes as properties fixed](https://github.com/Neft-io/document/commit/ad659fe4fa04802df01cee80a24894f377609ea5)
- [Element::visible now is properly set on cloned elements/texts](https://github.com/Neft-io/document/commit/b5bb9394c576c12759fb85077f677f7cae7085f2)
- [Element::cloneDeep() moved to the Tag class](https://github.com/Neft-io/document/commit/544f9569f745fe4c14399da49f0b9e7301b730a0)
- [File::toJSON() now process original file if exists](https://github.com/Neft-io/document/commit/f19f2fc9ad845a76bb019b847f9eea00149748f2)
- ['neft:function' sharing and json parsing bugs fixed](https://github.com/Neft-io/document/commit/d7decbb1a7d992789a212b475b732dac90bc814a)

## 0.8.25 - Bugs fixes
### Renderer
- [Cloning links in classes bug fixed](https://github.com/Neft-io/renderer/commit/8e8b611d2cc7858c2b6a2f8d22be24d9b0390579)
- [NumberAnimation bug with duplicated processing fixed](https://github.com/Neft-io/renderer/commit/f1af98712dd5269e6b1577809b6abdf9e497d655)
- [Transition no longer updates Animation duration](https://github.com/Neft-io/renderer/commit/0fe34e4ad6656070a67ac82c9c4ca61f308e4ae7)
