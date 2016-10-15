'use strict'

{log, unit, assert} = Neft
{describe, it, beforeEach, afterEach} = unit
{spy} = require 'sinon'

Log = log.constructor

describe 'src/log', ->
    testLog = null

    beforeEach ->
        class TestImpl extends log.Log
            @MARKERS =
                white: spy (str) -> "white #{str}"
                green: spy (str) -> "green #{str}"
                gray: spy (str) -> "gray #{str}"
                blue: spy (str) -> "blue #{str}"
                yellow: spy (str) -> "yellow #{str}"
                red: spy (str) -> "red #{str}"
                bold: spy (str) -> "bold #{str}"

            @time = spy -> 1
            @timeDiff = spy (since) ->
                since + 1

            _write: spy (msg) ->
            _writeError: spy (msg) ->

        testLog = new TestImpl

        Log.setGlobalLinesPrefix ''

    describe 'log()', ->
        it 'writes message', ->
            msg = 'test1'
            testLog.log msg
            assert.ok testLog._write.calledOnce
            assert.isEqual testLog._write.firstCall.args, ["white #{msg}"]

    describe 'log.once()', ->
        it 'writes message only once', ->
            msg = 'onceTest1'
            testLog.log.once msg
            assert.ok testLog._write.calledOnce
            assert.isEqual testLog._write.firstCall.args, ["white #{msg}"]

            testLog.log.once msg
            assert.ok testLog._write.calledOnce

            msg = 'onceTest2'
            testLog.log.once msg
            assert.ok testLog._write.calledTwice

    describe 'info()', ->
        it 'writes message', ->
            msg = 'test2'
            testLog.info msg
            assert.ok testLog._write.calledOnce
            assert.isEqual testLog._write.firstCall.args, ["blue #{msg}"]

    describe 'ok()', ->
        it 'writes message', ->
            msg = 'test3'
            testLog.ok msg
            assert.ok testLog._write.calledOnce
            assert.isEqual testLog._write.firstCall.args, ["green #{msg}"]

    describe 'warn()', ->
        it 'writes message', ->
            msg = 'test4'
            testLog.warn msg
            assert.ok testLog._write.calledOnce
            assert.isEqual testLog._write.firstCall.args, ["yellow #{msg}"]

    describe 'error()', ->
        it 'writes message', ->
            msg = 'test5'
            testLog.error msg
            assert.ok testLog._writeError.calledOnce
            assert.isEqual testLog._writeError.firstCall.args, ["red #{msg}"]
