# Install Neft

To install Neft make sure you have Node.js installed on your system.

Project can be easily created by typing `npx create-neft-project` or `yarn init neft-project`. Then follow the instructions on your screen.

Inside your project directory you can access Neft CLI by typing `npx neft` or `yarn neft`. Try it to see the help page.

Your basic project contains simple "Welcome in Neft" component you can use to start working on. Type `npx neft run html` or `yarn neft run html` to see the view in your browser. Try to edit the `./components/hello/hello.html` file. Your browser page should be automatically updated when changing the file.

This is the easiest way to start working with Neft on your computer.

If you don't want to configure your environment yet, check the "Introduction" section or the "Examples" page to play with Neft in your browser editor.

## Building Android project

To play with Neft you can use the "Examples" page and download the "Neft Playground" app on your device. If you want to run your local project, make sure you have Android SDK installed on your system and the path to it is accessible throught the `ANDROID_HOME` system environment (e.g. `ANDROID_HOME=/Users/demo/Library/Android/sdk/`).

Inside your Neft project type `npx neft run android` or `yarn neft run android`. Make sure your Android device is connected by the USB port with your computer (the project bundle needs to be sent to your device and run on it).

## Building iOS project

To play with Neft you can use the "Examples" page and download the "Neft Playground" app on your device.

To run your project locally, you need to have XCode installed on your Mac computer.

Inside your Neft project type `npx neft run ios` or `yarn neft run ios`. Then the XCode program will open shortly. Use it to run the project on your phone or inside the simulator.

## Building MacOS project

Follow the instructions of "Building iOS project", but using Neft CLI type `npx neft run macos` or `yarn neft run macos`.
