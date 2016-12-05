'use strict'

cp = require 'child_process'
os = require 'os'
fs = require 'fs-extra'
pathUtils = require 'path'

exports.getFileCommitSync = (repo, file) ->
    stdout = cp.execSync "cd #{repo} && git log -n1 --pretty=\"%H\" -- #{file}"
    String(stdout).trim()
