# Changelog

*Neft is in beta. All stupidness are treated as bugs.*

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
