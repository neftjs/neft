<img src="https://cdn.rawgit.com/Neft-io/neft/master/media/neft-white-full.svg" alt="Neft.io logo" width="256" />

## Universal Platform

<table>
    <tr>
        <th>Platform</th>
        <th>Code</th>
        <th>Views</th>
        <th>Styling</th>
        <th>Custom bindings</th>
        <th>Custom styling</th>
    </tr>
    <tr>
        <td>iOS</td>
        <td rowspan="6">JavaScript</td>
        <td rowspan="6">XML</td>
        <td rowspan="6">NML</td>
        <td>Swift / ObjC</td>
        <td>UIKit</td>
    </tr>
    <tr>
        <td>Android</td>
        <td>Java / C</td>
        <td>android.view</td>
    </tr>
    <tr>
        <td>OSX</td>
        <td>Swift / ObjC</td>
        <td>Cocoa</td>
    </tr>
    <tr>
        <td>Browser</td>
        <td rowspan="3">JavaScript</td>
        <td>HTML & CSS</td>
    </tr>
    <tr>
        <td>Browser WebGL</td>
        <td>Pixi.js</td>
    </tr>
    <tr>
        <td>Node</td>
        <td></td>
    </tr>
</table>

> `NML` - *Neft Marked Language* - Simple language used to describe styles, bindings and animations with [native controls](http://neft.io/extensions/native-items.html).

### What Neft does?

1. Runs your JavaScript code on [different platfoms](#everywhere).
2. Renders basic elements and native views through [extensions](http://neft.io/extensions.html).
3. Supports communication with native code.
4. Allows to write component-based views in XML and JavaScript.
5. Provides styling engine.

### What Neft does NOT?

1. Supports browser APIs. Neft is not a browser.
2. Understands CSS. Neft has his own [styling engine](http://neft.io/styles.html). CSS is too complex to implement on all native platforms. Instead you have more dynamic language but with less functionalities.

## Everywhere

- Node >= 0.11.14,
- Browsers (HTML5 or WebGL) IE >= 10,
- Android >= 4.0.0,
- iOS >= 8.0.

## Why Neft?

### One code for all

Share code between a truly native application, website and a server. Neft uses high-level abstraction easily portable between different platforms.

### Virtual DOM

DOM model powers native apps and websites in a better logic abstraction. Neft also renders on a server.

### Abstract styles

CSS alternative for more dynamic and cross-platform apps. Automatically synchronized with DOM. With [native elements](http://neft.io/extensions/native-items.html).

## Installation

```
npm install -g neft
```

## First app

```
neft create MyApp
cd MyApp
neft run node browser --watch
```

... and play with `MyApp/views/index.html`.

## Android native app

Specify your Android SDK path in `local.json` and run:

```
neft run android --watch
```

## iOS native app

Download XCode (8.1 or newer) on your Mac computer and run:

```
neft run ios --watch
```

## No examples, tutorials, bad docs quality

You can help with making Neft brilliant. [Contribute](http://neft.io/contribute.html).

Always create an issue if something doesn't work or can be improved.

*Neft is ours ;)*

* * *

### [Documentation](http://neft.io)

* * *

[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/Neft-io/neft)
<a href="https://twitter.com/neft_io"><img src="https://g.twimg.com/about/feature-corporate/image/followbutton.png" alt="Twitter" height="20" /></a>
[![npm version](https://badge.fury.io/js/neft.svg)](https://badge.fury.io/js/neft)
[![Build Status](https://travis-ci.org/Neft-io/neft.svg?branch=master)](https://travis-ci.org/Neft-io/neft)
[![Build status](https://ci.appveyor.com/api/projects/status/k3mj31b8406cwflv/branch/master?svg=true)](https://ci.appveyor.com/project/KrysKruk/neft/branch/master)
