'use strict'

File = require '../file.coffee.md'
specUtils = require './utils.coffee'

spec = specUtils File

describe 'View', ->

	it 'simple HTML is returned', -> spec.testFile 'simple'		
	it 'comment and white spaces are removing', -> spec.testFile 'clear'
	it 'JSON (like coffee syntax) in attrs are parsed as object', -> spec.testFile 'object-attrs'
	it 'elements are successfully replaced by units', -> spec.testFile 'elems'
	it 'units can be required', -> spec.testFile 'require'
	it 'unit is a scope for other units', -> spec.testFile 'scope'
	it 'unit can be placed multiple times', -> spec.testFile 'unit-cloning'
