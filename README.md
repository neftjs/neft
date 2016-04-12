<a href="http://www.neft.io"><img src="http://www.neft.io/static/images/neft-white.svg" alt="Neft" width="200"></a>

[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/Neft-io/neft)
[![npm version](https://badge.fury.io/js/neft.svg)](https://badge.fury.io/js/neft)
[![Build Status](https://travis-ci.org/Neft-io/neft.svg?branch=master)](https://travis-ci.org/Neft-io/neft)
<a href="https://twitter.com/neft_io"><img src="https://g.twimg.com/about/feature-corporate/image/followbutton.png" alt="Twitter" height="20" /></a>

# Neft

## JavaScript. Everywhere.

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

Now you know, why Neft was created - **Don't repeat boring stuff. Focus on a client.**

### Supported platforms

- Node >= 0.11.14,
- Browsers (HTML5 or WebGL) IE >= 9,
- Android >= 2.2.0 (API 8),
- iOS >= 8.0.

### What next?

Do you know JavaScript, CoffeeScript, C, Java or Swift? Help us and become a contributor. 🚀😃😎

Did you find a bug, have an idea for a new features or just you're pissed off at the documentation? Create an [issue](https://github.com/Neft-io/neft/issues), write it on our [Gitter](https://gitter.im/Neft-io/neft) or simply [tweet us](https://twitter.com/neft_io). 🚑💉

## WARNING

Neft is still in heavy development stage. Some of the published APIs may change. Documentation is partial. Any help is welcome. We're looking for a volunteers to work on a core functionalities, documentation, examples and on a native components implementations. Please remember that any feedback is appreciated.

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
var Dict = require('neft-dict');
module.exports = function(app){
    return {
        'get /': {
            getData: function(){
                return new Dict({
                    clicks: 0
                });
            },
            increaseClick: function(){
                this.data.set('clicks', this.data.clicks+1);
            }
        }
    }
};
```

### View

*views/index.html*

```html
<body>
    <p class="large" clicks="${scope.data.clicks}">Clicks ${scope.data.clicks}</p>
    <button style:pointer:onClick="${scope.increaseClick()}">+</button>
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
    property $.clicks: this.document.node.attrs.clicks
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

- [Document](https://github.com/Neft-io/neft-document),
- [Renderer](https://github.com/Neft-io/neft-renderer),
- [Android Runtime](https://github.com/Neft-io/neft-android-runtime),
- [iOS Runtime](https://github.com/Neft-io/neft-ios-runtime),
- [App](https://github.com/Neft-io/neft-app),
- [Resources](https://github.com/Neft-io/neft-resources),
- [Networking](https://github.com/Neft-io/neft-networking),
- [Native](https://github.com/Neft-io/neft-native),
- [Utils](https://github.com/Neft-io/neft-utils),
- [Schema](https://github.com/Neft-io/neft-schema),
- [Signal](https://github.com/Neft-io/neft-signal),
- [List](https://github.com/Neft-io/neft-list),
- [Dict](https://github.com/Neft-io/neft-dict),
- [Styles](https://github.com/Neft-io/neft-styles),
- [NML Parser](https://github.com/Neft-io/neft-nml-parser),
- [Typed Array](https://github.com/Neft-io/neft-typed-array),
- [Db](https://github.com/Neft-io/neft-db),
- [Bundle Builder](https://github.com/Neft-io/neft-bundle-builder),
- [Log](https://github.com/Neft-io/neft-log),
- [Unit](https://github.com/Neft-io/neft-unit),
- [Assert](https://github.com/Neft-io/neft-assert).

## GitHub links

You must be logged in.

- [Issues](https://github.com/issues?q=is%3Aissue+user%3ANeft-io+is%3Aopen),
- [Pull requests](https://github.com/issues?utf8=%E2%9C%93&q=is%3Apr+user%3ANeft-io+is%3Aopen+).
