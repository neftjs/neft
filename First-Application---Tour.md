First application
===

Neft is a JavaScript framework made for easy writing server-browser-native applications.

Neft is an Open Source project under the Apache 2.0 license. The source code is available in the GitHub service.

Installation
---

```bash
npm install -g neft
```

`npm` is the package manager for JavaScript installed in Node.

`-g` flag will install Neft globally.

Running
---

### Create

```bash
neft create MyApp
```

`MyApp` is the name of folder, where the app will be created.

This command creates a sample application with the server-client communication and simple list rendering.

### Run server

```bash
cd MyApp
neft run node
```

Neft on the server side uses Node.

The host and the port to listen is defined in the `package.json` file.
It's `localhost:3000` by the default.

### Run in a browser

```bash
neft run browser
```

To open your application in a browser, you need to run the server.

In further development, you can rebuild your app with no browser opening.

```bash
neft build browser
```

#### WebGL renderer

By default, Neft uses the HTML renderer in a browser.

If you want to use the WebGL renderer you can:
- change the `config.type` to `game` in the `pakcage.json`,
- use `/neft-type=game/` URI (e.g. `http://localhost:3000/neft-type=game/`).

#### Text mode

If you want to disable the renderer in a browser, you can:
- change the `config.type` to `text` in the `pakcage.json`,
- use `/neft-type=text/` URI (e.g. `http://localhost:3000/neft-type=text/`).

### Run on Android

```bash
neft run android
```

Your application will run on a device.

All Android files are in the `./build/android` folder.

If the Android SDK folder can't be found, specify its path in the `local.json` file.

### Run on iOS

```bash
neft run ios
```

This command runs the XCode on your Mac computer.

All iOS files are in the `./build/ios` folder.

### Production mode

When you are ready to publish your app, run a server and build client bundles using the `--release` flag.

```bash
neft run node --release
```

In the release mode, code is minified and all assertions are removing.

Next article: [[Application Structure - Tour]]
