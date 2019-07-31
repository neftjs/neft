const path = require('path')

exports.shouldLoadStaticFiles = false

exports.shouldBundle = true

exports.shouldProduceManifest = false

exports.shouldGenerateIcons = false

exports.getBundleConfig = ({ config, args }) => ({
  ...config,
  input: path.join(config.input, args.file),
  output: path.join(config.output, '../files/', path.parse(args.file).name),
  injectEnvs: false,
  bundleNodeModules: false,
  createMainAppEntryFile: false,
})
