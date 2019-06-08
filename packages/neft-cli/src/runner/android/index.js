const cp = require('child_process')
const fs = require('fs-promise-native')
const path = require('path')
const yaml = require('js-yaml')
const { logger } = require('@neft/core')
const { realpath } = require('../../config')

const apkDirPath = 'dist/android/app/build/outputs/apk/'
const adbPath = path.join(process.env.ANDROID_HOME || '', '/platform-tools/adb')

const logRe = /^(\d+-\d+\s[0-9:.]+)\s([A-Z])\/(?:Neft|AndroidRuntime)\s*\(\s*[0-9]+\):\s(.+)$/gm
const logLevelRe = /^(LOG|OK|INFO|WARN|ERROR):\s/

const matchLogs = (text) => {
  const matches = []
  let match = null
  logRe.lastIndex = 0
  // eslint-disable-next-line no-cond-assign
  while ((match = logRe.exec(text)) !== null) {
    const date = match[1]
    let level = match[2]
    let msg = match[3]
    if (logLevelRe.test(msg)) {
      const logLevelMatch = logLevelRe.exec(msg)
      // eslint-disable-next-line prefer-destructuring
      level = logLevelMatch[1]
      msg = msg.slice(logLevelMatch[0].length)
    }
    if (level === 'D' || level === 'LOG') {
      [level] = msg.split('  ', 1)
      if (['OK', 'INFO', 'WARN', 'ERROR'].includes(level)) {
        msg = msg.slice(level.length + 2)
      }
    }
    matches.push({ date, level, msg })
  }
  return matches
}

const installApk = ({ production }) => new Promise((resolve, reject) => {
  const mode = production ? 'release' : 'debug'

  const apkPath = `${apkDirPath}${mode}/app-universal-${mode}.apk`

  const adbCmd = `${adbPath} install -r ${apkPath}`
  const adb = cp.exec(adbCmd, (error) => {
    if (error) {
      const apkFiles = cp.execSync(`ls -l ${apkDirPath}/*`)
      reject(new Error(`Cannot install APK; available APK files: ${apkFiles}; root error: ${error}`))
      return
    }

    resolve()
  })

  adb.stdout.pipe(process.stdout)
  adb.stderr.pipe(process.stderr)
})

const getDeviceTime = () => {
  const shellDate = cp.execSync(`${adbPath} shell date +%m-%d_%H:%M:%S`)
  return new Date(String(shellDate).replace('_', ' ')).valueOf()
}

const startLogcat = () => {
  const args = ['logcat', '-v', 'time', 'Neft:v', '*:E', '-T', '1']
  const deviceTime = getDeviceTime()
  const logcat = cp.spawn(adbPath, args)
  logcat.stdout.on('data', (data) => {
    matchLogs(String(data)).forEach(({ date, level, msg }) => {
      if (new Date(date).valueOf() <= deviceTime) return
      if (msg.includes('FATAL EXCEPTION:')) {
        // wait for exception logs to be printed
        setTimeout(() => {
          logcat.kill()
          throw new Error('Process killed due to Android fatal exception')
        }, 2000)
      }
      switch (level) {
        case 'OK':
          logger.ok(msg)
          break
        case 'I':
        case 'INFO':
          logger.info(msg)
          break
        case 'W':
        case 'WARN':
          logger.warn(msg)
          break
        case 'E':
        case 'F':
        case 'ERROR':
          logger.error(msg)
          break
        default:
          logger.log(msg)
      }
    })
  })

  return logcat
}

const runApk = manifest => new Promise((resolve, reject) => {
  const cmd = `${adbPath} shell am start \
-a android.intent.action.MAIN \
-n ${manifest.package}/.MainActivity`
  const adb = cp.exec(cmd, (error) => {
    if (error) {
      reject(error)
      return
    }
    resolve()
  })
  adb.stdout.pipe(process.stdout)
  adb.stderr.pipe(process.stderr)
})

module.exports = async ({ production }) => {
  const manifestPath = path.join(realpath, 'manifest/android.yaml')
  const manifest = yaml.safeLoad(await fs.readFile(manifestPath, 'utf-8'))
  logger.info('Installing APK on the connected device')
  await installApk({ production })
  const logcat = startLogcat()
  try {
    logger.info('Running APK on the device')
    await runApk(manifest)
  } catch (error) {
    logcat.kill()
    throw error
  }
  logger.log('--------------------')
}
