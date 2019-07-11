/* eslint-disable no-await-in-loop */
/* eslint-disable no-restricted-syntax */
const fs = require('fs-extra')
const path = require('path')
const ParcelBundler = require('parcel-bundler')
const coffeeScriptParcelPlugin = require('parcel-plugin-coffee-script')

const NATIVE_DIRS_TO_BUNDLE = new Set(['html', 'webgl', 'browser'])

const bundleJsFile = async (cwd, entryDir, outDir, file) => {
  const entry = path.join(cwd, entryDir, file)
  const bundler = new ParcelBundler([entry], {
    outDir: path.join(cwd, outDir),
    watch: false,
    cache: false,
    hmr: false,
    minify: false,
    target: 'node',
    bundleNodeModules: false,
    scopeHoist: true,
  })

  coffeeScriptParcelPlugin(bundler)
  await bundler.bundle()
}

const bundleNativeDirs = async (realLocation) => {
  const nativeDirPath = path.join(realLocation, 'src/native')
  let nativeDirs = []
  try {
    nativeDirs = await fs.readdir(nativeDirPath)
  } catch (error) {
    // NOP
  }
  for (const nativeDir of nativeDirs) {
    if (NATIVE_DIRS_TO_BUNDLE.has(nativeDir)) {
      const entryDir = path.join('src/native', nativeDir)
      const outDir = path.join('lib/native', nativeDir)
      await bundleJsFile(realLocation, entryDir, outDir, 'index.js')
    }
  }
}

exports.build = async () => {
  const realpath = await fs.realpath('.')
  const packageJson = await fs.readJson(path.join(realpath, 'package.json'))
  if (!packageJson.main) {
    throw new Error('Given module has no "main" entry')
  }
  if (!packageJson.engines || packageJson.engines.node !== '0') {
    throw new Error('engindes.node needs to be set to 0 to force babel transpilation')
  }

  await bundleJsFile(realpath, 'src', 'lib', 'index.js')
  await bundleNativeDirs(realpath)
}
