'use strict'

cp = require 'child_process'
os = require 'os'
fs = require 'fs-extra'
pathUtils = require 'path'

exports.push = (callback) ->
    message = 'API Wiki update'
    cmd = ''
    cmd += 'git add -f wiki && '
    cmd += "git commit -m '#{message}' && "
    cmd += 'git subtree push --prefix wiki wiki master'
    cp.exec cmd, (err, stderr, stdout) ->
        callback stderr or err

exports.getFileCommitSync = (repo, file) ->
    stdout = cp.execSync "cd #{repo} && git log -n1 --pretty=\"%H\" -- #{file}"
    String(stdout).trim()
