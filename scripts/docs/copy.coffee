fs = require 'fs-extra'
glob = require 'glob'
pathUtils = require 'path'
{PATHS_TO_COPY, OUTPUT_DIR, DOCS_DIR} = require './config'

for pattern in PATHS_TO_COPY
    for path in glob.sync(pattern)
        if path.startsWith(DOCS_DIR)
            output = pathUtils.join OUTPUT_DIR, path
        else
            output = pathUtils.join OUTPUT_DIR, DOCS_DIR, path
        fs.copy path, output
