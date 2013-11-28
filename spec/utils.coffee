'use strict'

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