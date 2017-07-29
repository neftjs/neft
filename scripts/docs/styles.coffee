less = require 'less'
fs = require 'fs-extra'
pathUtils = require 'path'
{STYLES_DIR, MAIN_STYLE, OUTPUT_DIR} = require './config'

OUTPUT_EXTNAME = '.css'

file = fs.readFileSync pathUtils.join(STYLES_DIR, MAIN_STYLE), 'utf-8'
opts =
    paths: [STYLES_DIR]
    filename: MAIN_STYLE
less.render file, opts, (err, result) ->
    if err
        throw err
    pathProps = pathUtils.parse MAIN_STYLE
    outPath = pathUtils.join OUTPUT_DIR, STYLES_DIR, pathUtils.format
        dir: pathProps.dir
        name: pathProps.name
        ext: OUTPUT_EXTNAME
    fs.outputFile outPath, result.css
