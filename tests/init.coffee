{execSync} = require 'child_process'

TYPES = ['unit', 'cli', 'examples']

{argv, env} = process

# coverage arg
useCoverage = argv.indexOf('--coverage') >= 0

# test arg
shouldTest = exports.shouldTest = {}
shouldTestArgvExists = false
for type in TYPES
    shouldTest[type] = argv.indexOf("--#{type}") >= 0
    unless shouldTestArgvExists
        shouldTestArgvExists = shouldTest[type]
unless shouldTestArgvExists
    for type in TYPES
        shouldTest[type] = true

# sauce connect
useSauce = exports.useSauce = env.NEFT_TEST_BROWSER or
    env.NEFT_TEST_ANDROID or
    env.NEFT_TEST_IOS or
    false
if useSauce
    execSync 'npm install sauce-connect-launcher'
    execSync 'npm install wd'

# code coverage
if useCoverage
    execSync 'npm install coffee-coverage'
    execSync 'npm install coveralls'
    execSync 'npm install istanbul'
    require 'coffee-coverage/register-istanbul'

# register extensions
moduleCache = require 'lib/module-cache'
unless useCoverage
    moduleCache.registerFilenameResolver()
    moduleCache.registerCoffeeScript()
moduleCache.registerYaml()
moduleCache.registerTxt(['.txt', '.pegjs'])

# load Neft
global.Neft = require '../index'
global.Neft.unit = require 'lib/unit'
