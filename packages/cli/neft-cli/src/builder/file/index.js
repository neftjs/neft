const fs = require('fs')
const path = require('path')
const { logger } = require('@neft/core')

exports.shouldLoadStaticFiles = false

exports.shouldBundle = true

exports.shouldProduceManifest = false

exports.shouldGenerateIcons = false

exports.test = ({ args: { file } }) => {
  if (!file) {
    logger.error('`neft build file` requires file to be passed')
    logger.log('\nExample: `npx neft build file ./src/components/app/app.html`')
    return false
  }
  if (!fs.existsSync(file)) {
    logger.error(`Given file \`${file}\` doesn't exist`)
    return false
  }
  return true
}

exports.getBundleConfig = ({ config, args }) => ({
  ...config,
  input: path.join(config.input, args.file),
  output: path.join(config.output, '../files/', path.parse(args.file).name),
  injectEnvs: false,
  bundleNodeModules: false,
  createMainAppEntryFile: false,
})
