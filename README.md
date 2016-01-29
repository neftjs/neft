<a href="http://www.neft.io"><img src="http://www.neft.io/static/images/neft-white.svg" alt="Neft" width="200"></a>

# Neft CLI

[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/Neft-io/neft)
<a href="https://twitter.com/neft_io"><img src="https://g.twimg.com/about/feature-corporate/image/followbutton.png" alt="Twitter" height="20" /></a>

Neft is an Open Source JavaScript Framework made for server-browser-native applications. Neft.io is easy-to-use, fast and feature-focused.

Supported platforms: Node, Browsers (HTML5 / WebGL), iOS and Android.

Neft guarantees the same code across platforms.

Best features:
- Native renderers,
- Virtual DOM,
- HTML document extensions,
- Dynamic styles,
- Data binding (route-view-style),
- Routing,
- Resources system,
- Custom native communication,
- and more …

## Links

- [Official website](http://www.neft.io/)
- [Get Started](http://www.neft.io/get-started/index.md)
- [Documentation](http://www.neft.io/docs/app/index.coffee.md)

## Installation

```
npm install -g neft
```

## Running

```
neft create MyApp
cd MyApp
neft run node
neft run browser
neft run android
neft run ios
```

## License

Apache 2.0

## Example

### Routing

```javascript
var Dict = require('dict');
module.exports = function(app){
    return {
        'get /': {
            getData: function(){
                return new Dict({
                    clicks: 0
                });
            },
            increaseClicks: function(){
                this.data.set('clicks', this.data.get('clicks')+1);
            }
        }
    }
};
```

### View

```html
<p class="large" clicks="${data.clicks}">Clicks ${data.clicks}</p>
<button style:pointer:onClick="${route.increaseClick}">+</button>
```

### Styles

```javascript
Text {
    document.query: 'p'
    property $.clicks: 0
    background.color: 'yellow'

    if (this.$.clicks > 5){
        background.color: 'red'
    }
}

for ('p.large'){
    font.pixelSize: 23
}
```

## Components

- [Document](https://github.com/Neft-io/document),
- [Renderer](https://github.com/Neft-io/renderer),
- [Android Runtime](https://github.com/Neft-io/android-runtime),
- [iOS Runtime](https://github.com/Neft-io/ios-runtime),
- [App](https://github.com/Neft-io/app),
- [Resources](https://github.com/Neft-io/resources),
- [Networking](https://github.com/Neft-io/networking),
- [Native](https://github.com/Neft-io/native),
- [Utils](https://github.com/Neft-io/utils),
- [Schema](https://github.com/Neft-io/schema),
- [Signal](https://github.com/Neft-io/signal),
- [List](https://github.com/Neft-io/list),
- [Dict](https://github.com/Neft-io/dict),
- [Styles](https://github.com/Neft-io/styles),
- [NML Parser](https://github.com/Neft-io/nml-parser),
- [Typed Array](https://github.com/Neft-io/typed-array),
- [Db](https://github.com/Neft-io/db),
- [Bundle Builder](https://github.com/Neft-io/bundle-builder),
- [Log](https://github.com/Neft-io/log),
- [Unit](https://github.com/Neft-io/unit),
- [Assert](https://github.com/Neft-io/assert).
