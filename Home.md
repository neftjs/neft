# JavaScript Everywhere

## Everywhere

- Node >= 0.11.14,
- Browsers (HTML5 or WebGL) IE >= 10,
- Android >= 2.2.0 (API 8),
- iOS >= 8.0.

## Why Neft?

### One code for all

Share code between a truly native application, website and a server. Neft uses high-level abstraction easily portable between different platforms.

### Virtual DOM

DOM model powers native apps and websites in a better logic abstraction. Neft also render on the server.

### Abstract styles

CSS alternative for more dynamic and cross-platform apps. Automatically synchronized with DOM. With native elements.

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
neft run android
```

## iOS native app

Download XCode on your Mac computer and run:

```
neft run ios
```

## Android/iOS native views

Check out existing [[plugins|Plugins]] or write a new one (tutorial needed).

## Android/iOS native code

Check our [[native communication model|Native-Communication---Tour]] and implement your `native/android/CustomApp.java` or `native/ios/CustomApp.swift` boostrap app.

## No examples, tutorials, bad docs quality

Neft API is mostly stabilized. Now we are working on docs and tests improvements. You can help with making Neft brilliant. [[Contribute]]. Always create an issue if something doesn't work. Thank you!