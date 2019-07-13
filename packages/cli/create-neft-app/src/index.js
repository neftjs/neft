/* eslint-disable no-console */
const validateNpmPackageName = require('validate-npm-package-name')
const fs = require('fs-extra')
const path = require('path')
const os = require('os')
const chalk = require('chalk')
const { spawn, execSync } = require('child_process')

const name = process.argv[2]
const dependencies = ['@neft/cli', '@neft/core', '@neft/default-styles']
const devDependencies = ['@neft/websocket']

if (!name) {
  console.error('Specify the project name you want to create:')
  console.error('    npx create-neft-app my-app')
  process.exit(1)
}

const logCommand = (cmd) => {
  console.log(chalk.bold(`> ${cmd}`))
}

const validateName = () => {
  const validate = validateNpmPackageName(name)
  if (!validate.validForNewPackages) {
    console.error('Given project name cannot be used in NPM:')
    const errors = (validate.errors || []).concat(validate.warnings || [])
    errors.forEach((error) => { console.error(`  - ${error}`) })
    process.exit(1)
  }
}

const ensureDirIsEmpty = () => {
  logCommand(`mkdir ${name}`)
  try {
    const files = fs.readdirSync(name)
    if (files.length > 0) {
      console.error(`Folder '${name}' already exists; remove it and try again`)
      process.exit(1)
    }
  } catch (error) {
    // NOP
  }

  fs.ensureDirSync(name)
}

const createPackageJson = () => {
  const packageJson = {
    name,
    version: '0.1.0',
    private: true,
    main: './src',
  }
  const filepath = path.join(name, 'package.json')
  const file = JSON.stringify(packageJson, null, 2) + os.EOL
  fs.writeFileSync(filepath, file)
}

const executeNpmCommand = args => new Promise((resolve, reject) => {
  const cmd = 'npm'
  logCommand(`${cmd} ${args.join(' ')}`)
  const child = spawn(cmd, args, { cwd: name, stdio: 'inherit' })
  child.on('close', (code) => {
    if (code === 0) {
      resolve()
    } else {
      reject()
    }
  })
})

const installDependencies = async () => {
  const args = ['install', '--save'].concat(dependencies)
  await executeNpmCommand(args)
}

const installDevDependencies = async () => {
  const args = ['install', '--save-dev'].concat(devDependencies)
  await executeNpmCommand(args)
}

const createFiles = async () => {
  const src = path.join(__dirname, './files')
  await fs.copy(src, name)
}

const initGit = () => {
  execSync('git init', { cwd: name })
}

const main = async () => {
  validateName()
  ensureDirIsEmpty()
  createPackageJson()
  await installDependencies()
  await installDevDependencies()
  await createFiles()
  initGit()
  console.log()
  console.log(`You project '${name}' is ready at ${fs.realpathSync(name)}`)
  console.log(`Try ${chalk.yellow('npx neft run html')} inside that directory`)
  console.log()
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
