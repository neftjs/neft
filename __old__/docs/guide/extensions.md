# Extensions

Neft modules provides basic functions required to run simple application on various environments like:
 - rendering shapes, texts and images,
 - handling cursor, touch and keyboard events,
 - networking.

To build more complex and more customized application you need to use platform-specific and native APIs.

*Extensions* are used to wrap these APIs from different environments in one code available from your JavaScript application.

## Types of extensions

Extensions can be installed in three ways:

1. **Built-in Neft extensions** can be loaded by `package.json` *extensions* list. Check menu on the left to see a list of all available and supported extensions.
2. **Package extensions** are provided by contributors and can be installed through [NPM](https://www.npmjs.com/). Package name needs to be prefixed by `neft-` and installed to be properly added into your application.
3. **Custom extensions** are placed in your `extensions/` local folder and are automatically loaded. To see how to create your own extension, check some of the [built-in extensions](https://github.com/Neft-io/neft/tree/master/extensions/).
