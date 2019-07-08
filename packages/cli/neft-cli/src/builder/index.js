/* eslint-disable global-require */
const fs = require('fs').promises
const { unlinkSync } = require('fs')
const path = require('path')
const ParcelBundler = require('parcel-bundler')
const { logger } = require('@neft/core')
const neftParcelPlugin = require('@neft/parcel-plugin-neft')
const nmlParcelPlugin = require('@neft/parcel-plugin-nml')
const { getTargetEnv } = require('@neft/cli-env')
const styleCompiler = require('@neft/compiler-style')
const coffeeScriptParcelPlugin = require('parcel-plugin-coffee-script')
const { produceManifest } = require('./manifest')
const { generateIcons } = require('./icon')
const { loadStaticFiles } = require('./static')
const {
  realpath, outputDir, packageFile, outputFile, hmrServerPort, localIp,
} = require('../config')

const targetBuilders = {
  html: require('./browser'),
  webgl: require('./browser'),
  android: require('./android'),
  ios: require('./ios'),
}

const getExtensions = () => {
  const isOfficialExtensionName = name => name.startsWith('@neft/')
    && name !== '@neft/cli'
    && name !== '@neft/core'

  const isUnofficialExtensionName = name => name.startsWith('neft-')

  const isExtensionName = name => isOfficialExtensionName(name)
    || isUnofficialExtensionName(name)

  const result = []
  let ok = true

  Object.keys(packageFile.dependencies || {})
    .filter(isExtensionName)
    .forEach((name) => {
      const extensionPath = require.resolve(name, { paths: [realpath] })
      const shortName = isOfficialExtensionName(name)
        ? name.split('@neft/')[1]
        : name.split('neft-')[1]
      try {
        result.push({
          name,
          shortName,
          path: extensionPath,
          dirPath: path.dirname(extensionPath),
        })
      } catch (error) {
        if (error.code === 'MODULE_NOT_FOUND') {
          ok = false
          logger.error(`**${name}** is a dependency in your package.json, but the module is not installed; try \`npm install\``)
        } else {
          throw error
        }
      }
    })

  if (!ok) process.exit(1)

  return result
}

const getDefaultStyles = async ({ extensions }) => {
  const styleExtensions = await Promise.all(extensions.map(async (ext) => {
    const indexNml = path.join(path.dirname(ext.path), '/style.nml')
    try {
      const file = await fs.readFile(indexNml, 'utf-8')
      const bundle = styleCompiler.bundle(file, {
        resourcePath: ext.name,
      })
      return {
        name: ext.name,
        path: path.join(ext.name, '/style.nml'),
        queries: bundle.queries,
      }
    } catch (error) {
      return null
    }
  }))

  return styleExtensions.filter(Boolean)
}

const createEntryFile = async ({
  input, extensions, imports, initCode,
}) => {
  const polyfills = ['core-js/stable', 'regenerator-runtime/runtime']

  let file = ''

  polyfills.forEach((polyfill) => {
    file += `require('${polyfill}')\n`
  })

  extensions.forEach((extension) => {
    file += `require('${extension.name}')\n`
  })

  imports.forEach((importPath) => {
    file += `require('${importPath}')\n`
  })

  file += initCode

  file += "module.exports = require('./')"

  const filename = path.join(input, '.neft-entry.js')
  await fs.writeFile(filename, file)

  process.on('exit', () => {
    unlinkSync(filename)
  })

  return filename
}

exports.bundle = async (target, {
  input, output, extensions = [], imports = [], production = false, watch = false,
  initCode = '',
}) => {
  const parcelOptions = {
    outDir: output,
    outFile: outputFile,
    cacheDir: path.resolve(realpath, './node_modules/', '.cache'),
    watch,
    hmr: watch,
    hmrHostname: localIp,
    hmrPort: hmrServerPort,
    minify: production,
    target: 'browser',
    bundleNodeModules: true,
    logLevel: 2,
  }
  const defaultStyles = await getDefaultStyles({ extensions })
  const entry = await createEntryFile({
    input, extensions, imports, initCode,
  })
  const entries = [entry]
  const bundler = new ParcelBundler(entries, parcelOptions)
  bundler.options.env = {
    ...getTargetEnv({ production, target }),
    NEFT_PARCEL_EXTENSIONS: JSON.stringify(extensions),
    NEFT_PARCEL_DEFAULT_STYLES: JSON.stringify(defaultStyles),
  }
  neftParcelPlugin(bundler)
  nmlParcelPlugin(bundler)
  coffeeScriptParcelPlugin(bundler)

  await bundler.bundle()

  if (watch) {
    let logline
    bundler.on('buildStart', () => {
      logline = logger.line().timer().loading('Build changes')
    })
    bundler.on('buildError', (err) => {
      logline.error(`Cannot build changes: \`${err.message}\``).stop()
    })
    bundler.on('bundled', () => {
      logline.ok('Changes built').stop()
    })
  }
}

exports.build = async (target, args) => {
  const logline = logger.line().timer().loading(`Build **${target}**`)

  const production = !!args.production
  const watch = !!args.run
  const targetBuilder = targetBuilders[target]
  const input = realpath
  const output = path.join(outputDir, target)
  const filepath = path.join(output, outputFile)
  const extensions = getExtensions()
  let imports

  logline.loading(`Build **${target}** - parse static files`)
  const staticFilesCode = await loadStaticFiles()

  logline.loading(`Build **${target}** - bundle`)
  if (typeof targetBuilder.getImports === 'function') {
    imports = await targetBuilder.getImports({ input, target, extensions })
  }
  await exports.bundle(target, {
    input, output, extensions, imports, production, watch, initCode: staticFilesCode,
  })

  logline.loading(`Build **${target}** - produce manifest`)
  const manifest = await produceManifest({ ...targetBuilder, target, output })

  logline.loading(`Build **${target}** - generate icons`)
  await generateIcons({ ...targetBuilder, target, manifest })

  logline.loading(`Build **${target}** - build ${target} project`)
  await targetBuilder.build({
    manifest, output, filepath, production, extensions,
  })

  logline.log(`✔ Built **${target}**`).stop()
  if (!args.run) logger.log(`Bundle is located in \`${path.relative(realpath, output)}\``)
}
