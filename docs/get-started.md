# Get Started

## tl;dr

```
npm install neft -g
neft create MyApp
cd MyApp
neft run node browser --watch
```

... and play with `MyApp/views/index.html`;

or alternatively:
- `neft run ios --watch`,
- `neft run android --watch`.

* * *

## Installation

To install Neft make sure you have installed [Node.js](https://nodejs.org/) in version 0.11.14 or newer.
*Node* is an open-source JavaScript runtime environment.

Then you can easily install Neft on your machine by typing `npm install neft -g` in your terminal.

*npm* is the package manager for JavaScript installed by default in [Node.js](https://nodejs.org/).

Now you can type `neft` and see the help page.

## Creating app

Neft application is a folder with standardized structure and `package.json` file.

It's recommended to create application folder by typing `neft create MyAppName`.

This command creates folder (e.g. *MyAppName*) with main view (`views/index.html`) and meta-data `package.json` file.

## Running app

Each time you change the code of your application, you need to build the bundle.
You can do this by typing `neft build browser`.
In place of `browser` provide a platform you want to support. You can choose from `node`, `browser`, `ios` and `android`.

By typing, for instance, `neft run ios` you will automatically build and run the application.

If you want to run your application in a browser (`neft run browser`), make sure you firstly run *node* server (`neft run node`) which serves all needed files for the browser.

Server hostname and port are defined in the `package.json` file. It's `localhost:3000` by default.

### WebGL renderer

By default, Neft uses the HTML renderer in a browser.

If you want to use the WebGL renderer you can:
- change the `config.type` to `game` in `package.json`,
- use `/neft-type=game/` URI (e.g. `http://localhost:3000/neft-type=game/`).

### Text mode

If you want to disable the renderer in a browser and see how Google see your page, you can:
- change the `config.type` to `text` in `package.json`,
- use `/neft-type=text/` URI (e.g. `http://localhost:3000/neft-type=text/`).

## Production mode

When you are ready to publish your app, build client bundles using the `--release` flag.

```
neft run node --release
```

In the release mode, code is minified and all assertions are removed.

## Local configuration file

In your application folder, you can find `local.json` file.

This file is used to configure your local environment. It's ignored by Git (see `.gitignore` file in your application folder).

### Android

To build APK and run your application on Android device, you need to specify where, on your machine *Android SDK* is placed. See `android.sdkDir` in your `local.json` file.

## Watching on changes

To speed up coding, you can automatically rebuild the bundle each time you change something. Type `neft build android --watch` or whatever platform you want to support.

Application run in native environment will automatically restart.

To make it works, you will need to specify `buildServer.host` in your `local.json` file. We recommend to use your machine IP address.

Changing static files or custom native code requires you to rerun your application on a device manually.
