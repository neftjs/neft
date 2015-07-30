'use strict'

utils = require 'utils'
fs = require 'fs'
log = require 'log'
assert = require 'neft-assert'
pathUtils = require 'path'
yaml = require 'js-yaml'
try
	sharp = require 'sharp'

unless utils.isServer
	throw new Error "Resources.Parser can be run only on a server"

log = log.scope 'Resources', 'Parser'

IMAGE_FORMATS =
	__proto__: null
	png: true
	jpg: true
	jpeg: true
	gif: true

DEFAULT_CONFIG =
	resolutions: [1]

Resources = null
stack = null
logShowed = false

isResourcesPath = (path) ->
	/\/resources\.(?:json|yaml)$/.test path

toCamelCase = (str) ->
	words = str.split ' '
	r = words[0]
	for i in [1...words.length] by 1
		r += utils.capitalize words[i]
	r

resolutionToString = (resolution) ->
	if resolution is 1
		''
	else
		'@' + (resolution+'').replace('.', 'p') + 'x'

supportImageResource = (path, rsc) ->
	unless sharp
		unless logShowed
			log.error "Image formats are not supported, because 'sharp' module is not installed; install 'libvips' and later type 'npm install sharp'"
			logShowed = true
		return

	# get size
	stats = fs.statSync path
	mtime = new Date stats.mtime

	stack.add (callback) ->
		sharp(path).metadata (err, meta) ->
			if err
				return callback err

			name = pathUtils.basename path
			name = Resources.Resource.parseFileName name

			width = Math.round meta.width / name.resolution
			height = Math.round meta.height / name.resolution

			rsc.width = width
			rsc.height = height

			for format in rsc.formats
				for resolution in rsc.resolutions
					resPath = rsc.paths[format][resolution].slice(1)
					if not fs.existsSync(resPath) or new Date(fs.statSync(resPath).mtime) < mtime
						sharp(path).resize(width * resolution, height * resolution).toFile(resPath)
			callback()
			return

parseResourcesFolder = (path) ->
	throw "Resources folder not implemented"

parseResourcesFile = (path, config) ->
	assert.isString path

	file = fs.readFileSync path, 'utf-8'
	if pathUtils.extname(path) is '.yaml'
		json = yaml.safeLoad file
	else
		json = JSON.parse file

	getValue json, path, config

parseResourcesObject = (obj, dirPath, config) ->
	assert.isPlainObject obj

	if obj.resources?
		config = utils.clone config
		utils.merge config, obj
		delete config.resources
	else
		obj = resources: obj

	if dirPath.indexOf('.') isnt -1
		dirPath = pathUtils.dirname dirPath

	if Array.isArray(obj.resources)
		parseResourcesArray obj.resources, dirPath, config
	else
		rscs = new Resources
		for prop, val of obj.resources
			rscs[prop] = getValue val, dirPath, config
		rscs

parseResourcesArray = (arr, dirPath, config) ->
	obj = utils.arrayToObject arr, (_, val) ->
		name = val.file or val
		if isResourcesPath(name)
			pathUtils.dirname(name)
		else
			Resources.Resource.parseFileName(name).file
	parseResourcesObject obj, dirPath, config

parseResourceFile = (path, config) ->
	dirPath = pathUtils.dirname path
	name = pathUtils.basename path
	name = Resources.Resource.parseFileName(name)

	unless fs.existsSync(path)
		msg = "File '#{path}' doesn't exist"
		unless name.format
			msg += "; format is missed"
		log.error msg
		return

	rsc = new Resources.Resource

	newConfig = {}
	for key, val of config
		newConfig[toCamelCase(key)] = utils.cloneDeep val

	utils.merge rsc, newConfig

	if newConfig.file
		rsc.file = name.file

	if rsc.resolutions
		unless utils.has(rsc.resolutions, name.resolution)
			rsc.resolutions.push name.resolution
	else
		rsc.resolutions = [name.resolution]

	# remove greater resolutions
	rsc.resolutions = rsc.resolutions.filter (elem) ->
		elem <= name.resolution

	if rsc.formats
		# log.warn "Multiple formats are not currently supported; '#{rsc.formats}' got"
		unless utils.has(rsc.formats, name.format)
			rsc.formats.push name.format
	else
		rsc.formats = [name.format]

	paths = rsc.paths = {}
	for format in rsc.formats
		formatPaths = paths[format] = {}
		for resolution in rsc.resolutions
			resPath = "/#{dirPath}/#{name.file}#{resolutionToString(resolution)}.#{format}"
			formatPaths[resolution] = resPath

	if IMAGE_FORMATS[name.format]
		supportImageResource path, rsc

	rsc

getValue = (val, dirPath, config) ->
	if typeof val is 'string'
		path = pathUtils.join dirPath, val
		getFile path, config
	else if val?.file
		path = pathUtils.join dirPath, val.file
		config = utils.clone config
		utils.merge config, val
		delete config.file
		getFile path, config
	else if Array.isArray(val)
		parseResourcesArray val, dirPath, config
	else if utils.isObject(val)
		if val.resources?
			if Array.isArray(val.resources)
				parseResourcesArray val.resources, dirPath, config
			else
				parseResourcesObject val.resources, dirPath, config
		else
			config = utils.clone config
			utils.merge config, val
			parseResourceFile dirPath, config

getFile = (path, config) ->
	unless fs.existsSync(path)
		log.error "File '#{path}' doesn't exist"
		return

	stat = fs.statSync path
	jsonPathResourcesFile = pathUtils.join path, './resources.json'
	yamlPathResourcesFile = pathUtils.join path, './resources.yaml'

	if isResourcesPath(path)
		parseResourcesFile path, config
	else if stat.isDirectory()
		if fs.existsSync(jsonPathResourcesFile)
			parseResourcesFile jsonPathResourcesFile, config
		else if fs.existsSync(yamlPathResourcesFile)
			parseResourcesFile yamlPathResourcesFile, config
		else
			parseResourcesFolder path, config
	else
		parseResourceFile path, config

module.exports = ->
	[Resources] = arguments
	parse: (path, callback) ->
		stack = new utils.async.Stack
		rscs = getFile path, DEFAULT_CONFIG
		stack.runAllSimultaneously (err) ->
			callback err, rscs or ''
