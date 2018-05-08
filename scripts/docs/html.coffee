Mustache = require 'mustache'
fs = require 'fs-extra'
glob = require 'glob'
pathUtils = require 'path'
{INDEX_PAGE, API_PAGE, EXAMPLES_PAGE, OUTPUT_DIR} = require './config'

PARTIALS_GLOB = 'docs/template/**/*.mustache'
PARTIAL_NAME_RE = /^docs\/template\/(.*)\.mustache$/
OUTPUT_EXTNAME = '.html'

PARTIALS = do ->
    result = {}
    paths = glob.sync PARTIALS_GLOB
    for path in paths
        name = PARTIAL_NAME_RE.exec(path)[1]
        file = fs.readFileSync path, 'utf-8'
        Mustache.parse file
        result[name] = file
    result

compileFile = (path, view = {}, outputName) ->
    file = fs.readFileSync path, 'utf-8'
    html = Mustache.render file, view, PARTIALS
    pathProps = pathUtils.parse path
    outPath = pathUtils.join OUTPUT_DIR, pathUtils.format
        dir: pathProps.dir
        name: outputName or pathProps.name
        ext: OUTPUT_EXTNAME
    fs.outputFile outPath, html

getFileView = (view) ->
    view: view
    isMainPage: view.page is 'docs/index.mustache'
    isGuidePage: view.page is 'docs/guide.mustache'
    isApiPage: view.page is 'docs/api.mustache'
    isExamplesPage: view.page is 'docs/examples.mustache'

views = require './views'
compileFile INDEX_PAGE, getFileView(page: INDEX_PAGE)
compileFile API_PAGE, getFileView(page: API_PAGE)
compileFile EXAMPLES_PAGE, getFileView(page: EXAMPLES_PAGE)
for view in views
    compileFile view.page, getFileView(view), view.name
