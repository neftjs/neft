You can easily install Neft on your machine by typing `npm install neft -g` in your terminal which will install our framework globally. After that you can type `neft` and see the help page.

# Creating app

It's recommended to create application folder using `neft create MyAppName`.

In the given folder name (`MyAppName` from the example) you will find basic application structure with init files. Now you can work on this.

# Running app

Each time you change something in your application code, you need to build the bundle.
You can do this by typing `neft build browser`.
In place of `browser` provide a platform you want to support. You can choose from `node`, `browser`, `ios` and `android`.

By typing, for instance, `neft run ios` you will automatically build and run the application.

If you want to run the `brower` bundle, make sure you have running `node` server (`neft run node`) which serves all needed files for the browser.

# Watching on changes

To speed up your coding cycle, you can use special flags which will automatically rebuild bundle when you change a file `neft build browser --watch --notify`.