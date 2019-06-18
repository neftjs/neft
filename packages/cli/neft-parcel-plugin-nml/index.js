module.exports = (bundler) => {
  bundler.addAssetType('nml', require.resolve('./NmlAsset.js'))
}