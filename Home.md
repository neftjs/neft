# JavaScript Everywhere

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

CSS alternative for more dynamic and cross-platform apps. Automatically synchronized with DOM. With [native elements](https://github.com/Neft-io/neft/wiki/Default-Styles).

## Installation

```
npm install -g neft
```

## First app

```
neft create MyApp
cd MyApp
neft build browser
neft run node
.. open http://localhost:3000/ in a browser
```

## Android native app

Specify your Android SDK path in `local.json` and run:

```
neft run android --watch
```

## iOS native app

Download XCode on your Mac computer and run:

```
neft run ios --watch
```

## No examples, tutorials, bad docs quality

Neft API is mostly stabilized. Now we are working on docs and tests improvements. You can help with making Neft brilliant. [[Contribute]]. Always create an issue if something doesn't work. Thank you!

## Contribute

Our main goals are:
- improve documentation,
- add visual tests,
- OS X Cocoa renderer,
- Windows 10 through [UWP](https://en.wikipedia.org/wiki/Universal_Windows_Platform).