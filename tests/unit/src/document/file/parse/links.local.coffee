'use strict'

pathUtils = require 'path'
{getFilePath} = require 'src/document/file/parse/links'
utils = require 'src/utils'

describe 'document links parser', ->
    describe 'getFilePath', ->
        File = file = null
        pathUtilsState = utils.clone pathUtils

        beforeEach ->
            File = FILES_PATH: ''
            file = path: ''
            pathUtils.dirname = (a) -> "DIR(#{a})"
            pathUtils.join = (a, b) -> "_#{a}_+_#{b}_"

        afterEach ->
            utils.merge pathUtils, pathUtilsState

        describe 'for absolute path', ->
            it 'returns given path', ->
                path = "/abc"
                pathUtils.isAbsolute = -> true
                assert.is getFilePath(File, file, path), path

        describe 'for package path', ->
            it 'prefix given path by FILES_PATH', ->
                File.FILES_PATH = './views/abc'
                path = 'a123'
                expected = '_./views/abc_+_a123_'
                assert.is getFilePath(File, file, path), expected

        describe 'for relative path', ->
            it 'prefix given path by file dirname', ->
                file.path = 'dir/dirb/file.xhtml'
                path = './ab/a1.xhtml'
                expected = '_DIR(dir/dirb/file.xhtml)_+_./ab/a1.xhtml_'
                assert.is getFilePath(File, file, path), expected

        describe 'for relative path with backward references', ->
            it 'prefix given path by file dirname', ->
                file.path = 'dir/dirb/file.xhtml'
                path = '../ab/a1.xhtml'
                expected = '_DIR(dir/dirb/file.xhtml)_+_../ab/a1.xhtml_'
                assert.is getFilePath(File, file, path), expected
