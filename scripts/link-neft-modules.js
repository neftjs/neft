/* eslint-disable no-await-in-loop */
/**
 * ParcelJS has issues with resolving symlinked dependencies.
 * To fix that issue for local development we can publish @neft packages
 * into local npm registry (e.g. verdaccio) or manually copy them into the tested project.
 *
 * This script copies all neft packages into node_modules directory and install
 * their dependencies using npm.
 * Run it inside the tested project directory each time you changed neft package.
 *
 * Pass --no-install argument to disable installing external dependencies
 * using NPM to speed up the process.
 */

/* eslint-disable no-console */
/* eslint-disable no-restricted-syntax */
const fs = require('fs').promises
const path = require('path')
const { spawn } = require('child_process')

const NEFT_PACKAGES = path.join(__dirname, '../packages')

const getPackage = async dir => JSON.parse(await fs.readFile(path.join(dir, './package.json'), 'utf-8'))

const getNeftPackages = async () => {
  const result = []
  const dirs = await fs.readdir(NEFT_PACKAGES)
  for (const dir of dirs) {
    const dirPackages = await fs.readdir(path.join(NEFT_PACKAGES, dir))
    for (const neftPackage of dirPackages) {
      result.push(path.join(dir, neftPackage))
    }
  }
  return result
}

const tryMkdir = async (dir) => {
  try {
    await fs.mkdir(dir)
  } catch (error) {
    // NOP
  }
}

const spawnPromise = (...args) => new Promise((resolve, reject) => {
  const child = spawn(...args)
  child.on('error', reject)
  child.on('exit', resolve)
})

const main = async () => {
  const realpath = await fs.realpath('.')
  const nodeModulesOut = path.join(realpath, './node_modules/')
  const neftModulesOut = path.join(nodeModulesOut, './@neft/')
  const neftPackages = await getNeftPackages()
  const internalNames = new Set()
  const packageJsonFiles = {}
  const dependencies = {}

  const scanNeftPackage = async (packageName) => {
    const packagePath = path.join(NEFT_PACKAGES, packageName)
    const packageJson = await getPackage(packagePath)
    internalNames.add(packageJson.name)
    packageJsonFiles[packageName] = packageJson
    Object.assign(dependencies, packageJson.dependencies)
  }

  const linkNeftPackage = async (packageName) => {
    const packagePath = path.join(NEFT_PACKAGES, packageName)
    const packageJson = packageJsonFiles[packageName]

    const packageModules = path.join(packagePath, './node_modules')
    await spawnPromise('rm', ['-rf', packageModules])

    console.time(`Copy ${packageName}`)
    const destination = path.join(nodeModulesOut, packageJson.name)
    await spawnPromise('rsync', ['-a', `${packagePath}/`, destination])
    console.timeEnd(`Copy ${packageName}`)
  }

  await tryMkdir(nodeModulesOut)
  await tryMkdir(neftModulesOut)

  for (const neftPackage of neftPackages) {
    await scanNeftPackage(neftPackage)
  }

  if (!process.argv.includes('--no-install')) {
    // remove bin file, because npm freakes out
    await spawnPromise('rm', [path.join(nodeModulesOut, './.bin/neft')])

    const dependenciesToInstall = Object.entries(dependencies)
      .filter(([name]) => !internalNames.has(name))
      .map(([name, version]) => `${name}@${version}`)

    console.log(`Perform \`npm install --no-save ${dependenciesToInstall.join(' ')}\``)

    // install external dependencies
    await spawnPromise('npm', ['install', '--no-save', ...dependenciesToInstall], {
      cwd: realpath,
    })
  }

  for (const neftPackage of neftPackages) {
    await linkNeftPackage(neftPackage)
  }

  // copy bin file
  await spawnPromise('rsync', [path.join(NEFT_PACKAGES, 'cli/neft-cli/bin/neft.js'), path.join(nodeModulesOut, './.bin/neft')])
}

main()
