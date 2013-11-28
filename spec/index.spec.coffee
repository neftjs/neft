'use strict'

File = require '../file.coffee.md'
fs = require 'fs'

BASE = './spec/'

module.exports = (File) ->

	compare: compare = (file, html) ->

		str = str2 = null
		fail = false

		runs ->
			file.on 'ready', -> file.render.html -> [_, str] = arguments
			file.on 'error', -> fail = true
		waitsFor -> str or fail
		runs ->
			expect(fail).toBe false
			file.render.html -> [_, str2] = arguments
		waitsFor -> str2
		runs ->
			expect(fail).toBe false
			expect(str).toBe html
			expect(str2).toBe html

	testFile: (filename) ->

		runs -> 
			html = fs.readFileSync "#{BASE}html/#{filename}_expected.html", 'utf-8'
			file = new File "#{BASE}html/#{filename}.html"

			compare file, html

spec = module.exports File

describe 'View', ->

	it 'simple HTML is returned', -> spec.testFile 'simple'		
	it 'comment and white spaces are removing', -> spec.testFile 'clear'
	it 'JSON (like coffee syntax) in attrs are parsed as object', -> spec.testFile 'object-attrs'
	it 'elements are successfully replaced by units', -> spec.testFile 'elems'
	it 'units can be required', -> spec.testFile 'require'
	it 'unit is a scope for other units', -> spec.testFile 'scope'
	it 'unit can be placed multiple times', -> spec.testFile 'unit-cloning'
