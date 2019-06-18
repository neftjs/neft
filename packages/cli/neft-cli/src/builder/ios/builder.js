const fs = require('fs-extra')
const cp = require('child_process')
const path = require('path')
const glob = require('glob')
const yaml = require('js-yaml')
const xcode = require('xcode')
const Mustache = require('mustache')
const { promisify } = require('util')
const { util, logger } = require('@neft/core')
const { realpath, outputDir } = require('../../config')

const runtime = path.dirname(require.resolve('@neft/runtime-ios'))

const nativeDir = './native/ios'
const nativeDirOut = 'Neft/'

const iconsDir = path.join(outputDir, 'icon/ios')
const iconsDirOut = 'Neft/Assets.xcassets/AppIcon.appiconset'

const manifestAppDir = './manifest/ios/app'
const manifestAppDirOut = 'Neft'

const staticDirs = [path.join(realpath, 'static'), path.join(outputDir, 'static')]
const staticDirOut = 'static'

const extensionsDirOut = 'Neft/Extension/'

const pbxProject = 'Neft.xcodeproj/project.pbxproj'

const fontExtnames = {
  '.otf': true,
  '.ttf': true,
}

const getIosExtensions = async (extensions) => {
  const promises = extensions.map(async ({ dirPath }) => {
    const nativeDirPath = path.join(dirPath, 'native/ios')
    if (!(await fs.exists(nativeDirPath))) return null
    let name = /@neft\/([^/]+)/.exec(dirPath)[1]
    name = util.kebabToCamel(name)
    name = util.capitalize(name)
    return {
      dirPath, nativeDirPath, name,
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

const checkFontsSupported = () => new Promise((resolve) => {
  cp.exec('otfinfo --version', (error) => {
    if (error) {
      logger.error('Custom fonts are not supported; '
        + 'install `lcdf-typetools`; '
        + 'e.g. `brew install lcdf-typetools`')
    }
    resolve(!error)
  })
})

const copyIfExists = async (input, output, { filter } = {}) => {
  if (!(await fs.exists(input))) return
  await fs.copy(input, output, { filter })
}

const copyNativeDir = output => copyIfExists(nativeDir, path.join(output, nativeDirOut))

const copyIcons = output => copyIfExists(iconsDir, path.join(output, iconsDirOut))

const copyManifestApp = output => copyIfExists(manifestAppDir, path.join(output, manifestAppDirOut))

const copyStaticFiles = async (output, { fontsSupported }) => {
  const fonts = []

  const filter = (source) => {
    if (fontsSupported && fontExtnames[path.extname(source)]) {
      fonts.push(path.relative(realpath, source))
    }
    return true
  }

  const destination = path.join(output, staticDirOut)
  await fs.ensureDir(destination)

  // statics are saved into one folder so needs to be copied synchronously
  // in other case we will get EEXIST exception from fs-extra
  // eslint-disable-next-line no-restricted-syntax
  for (const dir of staticDirs) {
    // eslint-disable-next-line no-await-in-loop
    await copyIfExists(dir, destination, { filter })
  }

  return { fonts }
}

const resolveFont = async (filepath) => {
  const fileRealpath = await fs.realpath(filepath)
  const { stdout: name } = await promisify(cp.exec)(`otfinfo -p ${fileRealpath}`)
  return {
    source: `/${filepath}`,
    name: name.trim(),
  }
}

const resolveFonts = filepaths => Promise.all(filepaths.map(resolveFont))

const copyExtensions = async (output, extensions) => {
  await Promise.all(extensions.map(async ({ nativeDirPath, name }) => {
    await fs.copy(nativeDirPath, path.join(output, extensionsDirOut, name))
  }))
}

const processMustacheFile = async ({ source, destination }, config) => {
  const file = await fs.readFile(source, 'utf-8')
  const properDestination = destination.slice(0, -'.mustache'.length)
  const properFile = Mustache.render(file, config)
  await fs.writeFile(properDestination, properFile)
}

const assignManifest = (target, source) => {
  // infoPlist
  if (source.infoPlist) {
    target.infoPlist = target.infoPlist || ''
    target.infoPlist += `${source.infoPlist}\n`
  }
  // pods
  if (source.pods) {
    target.pods = target.pods || []
    target.pods.push(...source.pods)
  }
  // applicationDidFinishLaunching
  if (source.applicationDidFinishLaunching) {
    target.applicationDidFinishLaunching = target.applicationDidFinishLaunching || ''
    target.applicationDidFinishLaunching += `${source.applicationDidFinishLaunching}\n`
  }
}

const assignExtenionManifests = async (manifest, extensions) => {
  await Promise.all(extensions.map(async ({ dirPath }) => {
    const manifestPath = path.join(dirPath, 'manifest/ios.yaml')
    try {
      assignManifest(manifest, yaml.safeLoad(await fs.readFile(manifestPath, 'utf-8')))
    } catch (error) {
      // NOP
    }
  }))
}

const processMustacheFiles = (files, config) => {
  const promises = files.map(file => processMustacheFile(file, config))
  return Promise.all(promises)
}

const installPods = ({ output }) => new Promise((resolve, reject) => {
  const child = cp.spawn('pod', ['install'], { cwd: output, stdio: 'inherit' })
  child.on('exit', (code) => {
    if (code !== 0) {
      reject(new Error(`Cannot install CocoaPods packages;
make sure you've installed CocoaPods; e.g. brew install cocoapods`))
    } else {
      resolve()
    }
  })
})

const prepareXcodeProject = async ({ output, iosExtensions }) => {
  const pbxproj = path.join(output, pbxProject)
  const project = xcode.project(pbxproj)
  await promisify(project.parse).call(project)
  const mainGroupId = project.findPBXGroupKey({ path: 'Neft' })
  const extraFiles = await promisify(glob)(`${manifestAppDir}/*`)
  await Promise.all(extraFiles.map(async (source) => {
    const filename = path.relative(manifestAppDir, source)
    project.addSourceFile(filename, null, mainGroupId)
  }))
  await Promise.all(iosExtensions.map(async ({ nativeDirPath, name }) => {
    const fullName = `Extension${name}`
    const groupId = project.pbxCreateGroup(fullName, `Extension/${name}`)
    project.addToPbxGroup(groupId, mainGroupId)
    const extensionFiles = await fs.readdir(nativeDirPath)
    extensionFiles.forEach((extFile) => {
      project.addSourceFile(extFile, null, groupId)
    })
  }))
  await fs.writeFile(pbxproj, project.writeSync())
}

exports.build = async ({
  manifest, output, filepath, extensions,
}) => {
  logger.info('Preparing iOS build')

  const bundle = await fs.readFile(filepath, 'utf-8')
  const iosExtensions = await getIosExtensions(extensions)

  await fs.emptyDir(output)
  const { mustacheFiles } = await copyRuntime(output)
  const fontsSupported = await checkFontsSupported()

  const [{ fonts: fontPaths }] = await Promise.all([
    copyStaticFiles(output, { fontsSupported }), copyNativeDir(output),
    copyIcons(output), copyManifestApp(output), copyExtensions(output, iosExtensions),
    assignExtenionManifests(manifest, iosExtensions),
  ])

  const fonts = await resolveFonts(fontPaths)

  await processMustacheFiles(mustacheFiles, {
    fonts,
    bundle,
    manifest,
    extensions: iosExtensions,
  })

  if (manifest.pods && manifest.pods.length > 0) await installPods({ output })

  await prepareXcodeProject({ output, iosExtensions })
}
