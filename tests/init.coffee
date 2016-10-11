{execSync} = require 'child_process'

TYPES = ['unit', 'cli', 'examples']

{argv, env} = process

# coverage arg
useCoverage = !!env.NEFT_RUN_COVERAGE

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
exports.useSauce = env.NEFT_TEST_BROWSER or
    env.NEFT_TEST_ANDROID or
    env.NEFT_TEST_IOS or
    false

# code coverage
if useCoverage
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
