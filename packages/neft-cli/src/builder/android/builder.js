const fs = require('fs-extra')
const cp = require('child_process')
const path = require('path')
const yaml = require('js-yaml')
const Mustache = require('mustache')
const util = require('@neft/core/src/util')
const log = require('@neft/core/src/log')
const { realpath, outputDir } = require('../../config')

const runtime = path.join(__dirname, '../../../node_modules/@neft/runtime-android/')

const nativeDir = './native/android'
const nativeDirOut = 'app/src/main/java/io/neft/customapp'

const iconsDir = path.join(outputDir, 'icon/android')
const iconsDirOut = 'app/src/main/res'

const manifestAppDir = './manifest/android/app'
const manifestAppDirOut = 'app'

const staticDirs = [path.join(realpath, 'static'), path.join(outputDir, 'static')]
const staticDirOut = 'app/src/main/assets/static'

const extensionsDirOut = 'app/src/main/java/io/neft/extensions'

const mainActivity = 'app/src/main/java/__MainActivity__.java'
const mainActivityDirOut = 'app/src/main/java/'

const getAndroidExtensions = async (extensions) => {
  const promises = extensions.map(async (dirpath) => {
    const nativeDirpath = path.join(dirpath, 'native/android')
    if (!(await fs.exists(nativeDirpath))) return null
    let name = /@neft\/([^/]+)/.exec(dirpath)[1]
    name = util.kebabToCamel(name)
    name = util.capitalize(name)
    const packageName = `${name.toLowerCase()}_extension`
    return {
      dirpath, nativeDirpath, name, packageName,
    }
  })
  return (await Promise.all(promises))
    .filter(result => result != null)
}

const copyRuntime = async (output) => {
  const mustacheFiles = []
  await fs.copy(runtime, output, {
    filter(source, destination) {
      if (path.extname(source) === '.mustache') {
        mustacheFiles.push({ source, destination })
        return false
      }
      return true
    },
  })
  return { mustacheFiles }
}

const copyIfExists = async (input, output) => {
  if (!(await fs.exists(input))) return
  await fs.copy(input, output)
}

const copyNativeDir = output => copyIfExists(nativeDir, path.join(output, nativeDirOut))

const copyIcons = output => copyIfExists(iconsDir, path.join(output, iconsDirOut))

const copyManifestApp = output => copyIfExists(manifestAppDir, path.join(output, manifestAppDirOut))

const copyStaticFiles = async (output) => {
  // statics are saved into one folder so needs to be copied synchronously
  // in other case we will get EEXIST exception from fs-extra
  // eslint-disable-next-line no-restricted-syntax
  for (const dir of staticDirs) {
    // eslint-disable-next-line no-await-in-loop
    await copyIfExists(dir, path.join(output, staticDirOut))
  }
}

const copyExtensions = async (output, extensions) => {
  await Promise.all(extensions.map(async ({ nativeDirpath, packageName }) => {
    await fs.copy(nativeDirpath, path.join(output, extensionsDirOut, packageName))
  }))
}

const assignManifest = (target, source) => {
  // project.dependencies
  if (source.project && Array.isArray(source.project.dependencies)) {
    target.project = target.project || {}
    target.project.dependencies = target.project.dependencies || []
    target.project.dependencies.push(...source.project.dependencies)
  }

  // app.dependencies
  if (source.app && Array.isArray(source.app.dependencies)) {
    target.app = target.app || {}
    target.app.dependencies = target.app.dependencies || []
    target.app.dependencies.push(...source.app.dependencies)
  }

  // app.plugins
  if (source.app && Array.isArray(source.app.plugins)) {
    target.app = target.app || {}
    target.app.plugins = target.app.plugins || []
    target.app.plugins.push(...source.app.plugins)
  }

  // activityXmlManifest
  if (source.activityXmlManifest) {
    target.activityXmlManifest = target.activityXmlManifest || ''
    target.activityXmlManifest += `${source.activityXmlManifest}\n`
  }

  // applicationXmlManifest
  if (source.applicationXmlManifest) {
    target.applicationXmlManifest = target.applicationXmlManifest || ''
    target.applicationXmlManifest += `${source.applicationXmlManifest}\n`
  }
}

const assignExtenionManifests = async (manifest, extensions) => {
  await Promise.all(extensions.map(async ({ dirpath }) => {
    const manifestPath = path.join(dirpath, 'manifest/android.yaml')
    try {
      assignManifest(manifest, yaml.safeLoad(await fs.readFile(manifestPath, 'utf-8')))
    } catch (error) {
      // NOP
    }
  }))
}

const processMustacheFile = async ({ source, destination }, config) => {
  const file = await fs.readFile(source, 'utf-8')
  const properDestination = destination.slice(0, -'.mustache'.length)
  const properFile = Mustache.render(file, config)
  await fs.writeFile(properDestination, properFile)
}

const processMustacheFiles = (files, config) => {
  const promises = files.map(file => processMustacheFile(file, config))
  return Promise.all(promises)
}

const prepareMainActivity = async (manifest, output) => {
  const packagePath = manifest.package.replace(/\./g, '/')
  const source = path.join(output, mainActivity)
  const destination = path.join(output, mainActivityDirOut, packagePath, 'MainActivity.java')
  await fs.move(source, destination)
}

const assembleApk = (production, output) => new Promise((resolve, reject) => {
  const gradleMode = production ? 'assembleRelease' : 'assembleDebug'
  let cmd
  if (process.platform.startsWith('win')) {
    cmd = `./gradlew.bat ${gradleMode} --quiet`
  } else {
    cmd = `chmod +x gradlew && ./gradlew ${gradleMode} --quiet`
  }
  const gradleProcess = cp.exec(cmd, { cwd: output }, (error) => {
    if (error) reject(error)
    else resolve()
  })
  gradleProcess.stdout.pipe(process.stdout)
})

exports.build = async ({
  manifest, output, filepath, extensions, production,
}) => {
  if (!process.env.ANDROID_HOME) {
    throw new Error('ANDROID_HOME environment variable need to be set to the Android SDK location')
  }

  log.info('Preparing Android build')

  const bundle = await fs.readFile(filepath, 'utf-8')
  const androidExtensions = await getAndroidExtensions(extensions)

  await fs.emptyDir(output)
  const { mustacheFiles } = await copyRuntime(output)

  await Promise.all([
    copyNativeDir(output), copyIcons(output), copyManifestApp(output),
    copyStaticFiles(output), copyExtensions(output, androidExtensions),
    assignExtenionManifests(manifest, androidExtensions),
  ])

  await processMustacheFiles(mustacheFiles, {
    bundle,
    manifest,
    extensions: androidExtensions,
  })

  await prepareMainActivity(manifest, output)

  log.info('Building Android APK')
  await assembleApk(production, output)
}
