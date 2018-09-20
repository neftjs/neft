fs = require 'fs'
path = require 'path'
cp = require 'child_process'

BUNDLE_PATH = path.join(__dirname, '../cli/bundle')

if not process.env.CI and not fs.existsSync(BUNDLE_PATH)
    fs.mkdirSync BUNDLE_PATH
    cp.execSync 'npm install && npm run bundle', stdio: [0, 1, 2]
