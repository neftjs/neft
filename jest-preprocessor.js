const coffee = require('coffee-script');
const babelJest = require('babel-jest');

module.exports = {
    process: (src, path, ...rest) => {
        if (coffee.helpers.isCoffee(path)) {
            compiled_to_js = coffee.compile(src, {bare: true, literate: path.endsWith('.litcoffee')});
            return babelJest.process(compiled_to_js, path, ...rest);
        }
        return src;
    }
};
