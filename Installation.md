To install Neft make sure you have installed [Node.js](https://nodejs.org/) in version 0.11.14 or newer.
*Node* is an open-source JavaScript runtime environment.

Then you can easily install Neft on your machine by typing `npm install neft -g` in your terminal.

This command will install Neft framework globally. After that you can type `neft` and see the help page.

# Creating app

Neft application is a folder with standardized structure and `package.json` file.

It's recommended to create application folder by typing `neft create MyAppName`.

This command creates folder (e.g. *MyAppName*) with main view (`views/index.html`) and meta-data `package.json` file.

# Running app

Each time you change the code of your application, you need to build the bundle.
You can do this by typing `neft build browser`.
In place of `browser` provide a platform you want to support. You can choose from `node`, `browser`, `ios` and `android`.

By typing, for instance, `neft run ios` you will automatically build and run the application.

If you want to run your application in a browser (`neft run browser`), make sure you firstly run *node* server (`neft run node`) which serves all needed files for the browser.

# Local configuration file

After first build, in your application folder, you'll find `local.json` file.

This file is used to configure your local environment. It's ignored by Git (see `.gitignore` file in your application folder).

## Android

To build APK and run your application on Android device, you need to specify where, on your machine *Android SDK* is placed. See `android.sdkDir` in your `local.json` file.

# Watching on changes

To speed up coding, you can automatically rebuild the bundle each time you change something. Type `neft build android --watch` or whatever platform you want to support.

Application run in native environment will automatically restart.

To make it works, you will need to specify `buildServer.host` in your `local.json` file. We recommend to use your machine IP address.