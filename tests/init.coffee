glob = require 'glob'

{argv, env} = process

# config
exports.useCoverage = !!env.NEFT_RUN_COVERAGE
exports.useSauce = env.NEFT_TEST_BROWSER or
    env.NEFT_TEST_ANDROID or
    env.NEFT_TEST_IOS or
    false

# run code coverage
if exports.useCoverage
    require 'coffee-coverage/register-istanbul'

# register extensions
moduleCache = require 'lib/module-cache'
unless exports.useCoverage
    moduleCache.registerFilenameResolver()
    moduleCache.registerCoffeeScript()
moduleCache.registerYaml()
moduleCache.registerTxt(['.txt', '.pegjs'])

# load Neft
global.Neft = require '../index'
global.Neft.unit = require 'lib/unit'

# load tests
do ->
    CWD = 'tests/'
    ignoreArgv = do ->
        ignoreIndex = argv.indexOf('--ignore')
        if ignoreIndex >= 0 then (argv[ignoreIndex + 1] + '').split ',' else []
    files = glob.sync '**/*.coffee',
        cwd: CWD
        ignore: [ignoreArgv..., 'init.coffee', 'utils/**/*']
    for file in files
        require CWD + file
