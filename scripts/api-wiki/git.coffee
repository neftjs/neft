'use strict'

cp = require 'child_process'
os = require 'os'
fs = require 'fs-extra'
pathUtils = require 'path'

exports.clone = (url, callback) ->
    dest = pathUtils.join os.tmpDir(), '/', String(Math.random()).slice(2)
    fs.removeSync dest

    cp.exec "git clone #{url} #{dest}", (err) ->
        callback err

    dest

exports.push = (repo, callback) ->
    message = 'Automatic API Wiki update'
    cmd = "cd #{repo} && "
    cmd += 'git add --all && '
    cmd += "git commit -m '#{message}' && "
    cmd += 'git push'
    cp.exec cmd, (err, stderr, stdout) ->
        callback stderr or err

exports.getFileCommitSync = (repo, file) ->
    stdout = cp.execSync "cd #{repo} && git log -n1 --pretty=\"%H\" -- #{file}"
    String(stdout).trim()
