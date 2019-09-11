/* eslint-disable global-require */
const fs = require('fs').promises
const { unlinkSync, existsSync } = require('fs')
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
  file: require('./file'),
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
      let dirPath = extensionPath
      do {
        dirPath = path.dirname(dirPath)
      } while (!existsSync(path.join(dirPath, 'package.json')) || !dirPath)
      try {
        result.push({
          name,
          shortName,
          path: extensionPath,
          dirPath,
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
    const indexNml = path.join(ext.dirPath, '/style.nml')
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

const getDefaultComponents = async ({ extensions }) => {
  const components = await Promise.all(extensions.map(async (ext) => {
    const files = await fs.readdir(ext.dirPath)
    return files
      .filter(file => neftParcelPlugin.neftExtnames.has(path.extname(file)))
      .map(file => ({
        name: path.parse(file).name,
        path: path.join(ext.name, file),
      }))
  }))

  return [].concat(...components) // flat
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

const createEntryLink = async (input) => {
  const file = `module.exports = require('./${path.relative(realpath, input)}')`

  const filename = path.join(realpath, '.neft-entry.js')
  await fs.writeFile(filename, file)

  process.on('exit', () => {
    unlinkSync(filename)
  })

  return filename
}

exports.bundle = async (target, {
  input, output, extensions = [], imports = [], production = false, watch = false,
  initCode = '', injectEnvs = true, bundleNodeModules = true,
  createMainAppEntryFile = true,
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
    target: injectEnvs ? 'browser' : 'node',
    bundleNodeModules,
    sourceMaps: false,
    logLevel: 2,
  }
  const [defaultStyles, defaultComponents, entry] = await Promise.all([
    getDefaultStyles({ extensions }),
    getDefaultComponents({ extensions }),
    createMainAppEntryFile ? createEntryFile({
      input, extensions, imports, initCode,
    }) : createEntryLink(input),
  ])
  const entries = [entry]
  const bundler = new ParcelBundler(entries, parcelOptions)
  bundler.options.env = {
    ...(injectEnvs && getTargetEnv({ production, target })),
    NODE_ENV: production ? 'production' : 'development',
    NEFT_PARCEL_EXTENSIONS: JSON.stringify(extensions),
    NEFT_PARCEL_DEFAULT_STYLES: JSON.stringify(defaultStyles),
    NEFT_PARCEL_DEFAULT_COMPONENTS: JSON.stringify(defaultComponents),
  }
  neftParcelPlugin(bundler)
  nmlParcelPlugin(bundler)
  coffeeScriptParcelPlugin(bundler)

  await bundler.bundle()

  if (watch) {
    bundler.on('buildStart', () => {
      logger.log('Building changed files')
    })
    bundler.on('buildError', (err) => {
      logger.error(`Cannot build changes: \`${err.message}\``)
    })
    bundler.on('bundled', () => {
      logger.ok('Changes built')
    })
  }
}

exports.build = async (target, args) => {
  logger.log(`\`Building **${target}** target\``)
  const production = !!args.production
  const watch = !!args.run
  const targetBuilder = targetBuilders[target]
  const input = realpath
  let output = path.join(outputDir, target)
  const filepath = path.join(output, outputFile)
  const extensions = getExtensions()
  const {
    shouldLoadStaticFiles, shouldBundle,
    shouldProduceManifest, shouldGenerateIcons,
  } = targetBuilder

  if (typeof targetBuilder.test === 'function') {
    if (!targetBuilder.test({ args })) {
      process.exit(1)
    }
  }

  let staticFilesCode
  if (shouldLoadStaticFiles) {
    logger.log('-> Parsing static files')
    staticFilesCode = await loadStaticFiles()
  }

  if (shouldBundle) {
    logger.log('-> Bundling')
    let imports
    if (typeof targetBuilder.getImports === 'function') {
      imports = await targetBuilder.getImports({ input, target, extensions })
    }
    let config = {
      input, output, extensions, imports, production, watch, initCode: staticFilesCode,
    }
    if (typeof targetBuilder.getBundleConfig === 'function') {
      config = targetBuilder.getBundleConfig({ config, args })
    }
    ({ output } = config)
    await exports.bundle(target, config)
  }

  let manifest
  if (shouldProduceManifest) {
    logger.log('-> Reading manifest file')
    manifest = await produceManifest({ ...targetBuilder, target, output })
  }

  if (shouldGenerateIcons) {
    logger.log('-> Generating icons')
    await generateIcons({ ...targetBuilder, target, manifest })
  }

  if (typeof targetBuilder.build === 'function') {
    logger.log('-> Building platform project')
    await targetBuilder.build({
      manifest, output, filepath, production, extensions,
    })
  }

  logger.ok(`Target **${target}** is ready`)
  if (!args.run) logger.log(`The bundle is located in \`${path.relative(realpath, output)}\``)
}
