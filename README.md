<a href="http://www.neft.io"><img src="http://www.neft.io/static/images/neft-white.svg" alt="Neft" width="200"></a>

# Neft

## JavaScript. Everywhere.

[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/Neft-io/neft)
[![npm version](https://badge.fury.io/js/neft.svg)](https://badge.fury.io/js/neft)
<a href="https://twitter.com/neft_io"><img src="https://g.twimg.com/about/feature-corporate/image/followbutton.png" alt="Twitter" height="20" /></a>

*Native, Browser, Server*

### Manifest

1. One Routing for all.
2. Virtual HTML document for native.
3. Abstract styles with platform-specified elements.

### Why?

We ❤ ️JavaScript. It's simple to learn and widely supported language.
Native apps need to be **trully** native - very fast and with platform-specified elements.
If you have a native app, why not to reduce it and use like a mobile website?
Have a mobile version of your website? Change few styles and prepare a normal website.
Needs to be visible in Google? Run Node and serve HTML documents used in the client app for a better logic separation.

Now you know, why Neft was created - **Don't repeat boring stuff. Focus on client.**

### Supported platforms

- Node >= 0.11.14,
- Browsers (HTML5 or WebGL) IE >= 9,
- Android >= 2.2.0 (API 8),
- iOS >= 8.0.

## Links

- [Official website](http://www.neft.io/)
- [Get Started](http://www.neft.io/get-started/index.md)
- [Documentation](http://www.neft.io/docs/app/index.coffee.md)
- [Changelog](https://github.com/Neft-io/neft-cli/blob/master/CHANGELOG.md)

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

*routes/index.js*

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
            increaseClick: function(){
                this.data.set('clicks', this.data.get('clicks')+1);
            }
        }
    }
};
```

### View

*views/index.html*

```html
<body>
    <p class="large" clicks="${data.clicks}">Clicks ${data.clicks}</p>
    <button style:pointer:onClick="${route.increaseClick()}">+</button>
</body>
```

### Styles

*styles/view.js*

```javascript
Scrollable {
    contentItem: Flow {
        document.query: 'body'
    }
}
```

*styles/index.js*

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

for ('button'){
    border.color: 'gray'
    border.width: 2
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
