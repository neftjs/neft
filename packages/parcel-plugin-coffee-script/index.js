const TYPES = ['coffee', 'litcoffee', 'coffee.md']

module.exports = (bundler) => {
  TYPES.forEach((type) => {
    bundler.addAssetType(type, require.resolve('./CoffeeScriptAsset.js'))
  })
}