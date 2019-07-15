const ASSET_TYPES = ['neft', 'xhtml', 'html']

module.exports = (bundler) => {
  ASSET_TYPES.forEach((asset) => {
    bundler.addAssetType(asset, require.resolve('./NeftAsset.js'))
  })
}

module.exports.neftExtnames = new Set(ASSET_TYPES.map(type => `.${type}`))
