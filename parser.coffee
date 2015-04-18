'use strict'

Resources = require './index'
fs = require 'fs'
log = require 'log'
utils = require 'utils'
assert = require 'neft-assert'
pathUtils = require 'path'
try
	sharp = require 'sharp'

log = log.scope 'Resources', 'Parser'

IMAGE_FORMATS =
	__proto__: null
	png: true
	jpg: true
	jpeg: true
	gif: true
DEFAULT_CONFIG =
	resolutions: [1]

isResourcesPath = (path) ->
	/\/resources\.json$/.test path

resolutionToString = (resolution) ->
	if resolution is 1
		''
	else
		'@' + (resolution+'').replace('.', 'p') + 'x'

supportImageResource = (path, rsc) ->
	unless sharp
		log.error "Image formats are not supported, because 'sharp' module is not installed; install 'libvips' and later type 'npm install sharp'"
		return

	# get size
	stats = file.statSync path
	mtime = new Date stats.mtime

	sharp(path).metadata (err, meta) ->
		if err
			return
		{width, height} = meta
		rsc.width = width
		rsc.height = height

		for format in rsc.formats
			for resolution in rsc.resolutions
				resPath = rsc.paths[format][resolution]
				if not fs.existsSync(resPath) or new Date(fs.statSync(resPath).mtime) < mtime
					sharp(path).resize(width * resolution, height * resolution).toFile(resPath)
		return

parseResourcesFolder = (path) ->
	throw "Resources folder not implemented"

parseResourcesFile = (path, config) ->
	assert.isString path

	file = fs.readFileSync path, 'utf-8'
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

	if IMAGE_FORMATS[name.format]
		rsc = new Resources.ImageResource
	else
		rsc = new Resources.Resource

	config = utils.cloneDeep config
	utils.merge rsc, config

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
		log.warn "Multiple formats are not currently supported; '#{rsc.formats}' got"
		# unless utils.has(rsc.formats, name.format)
		# 	rsc.formats.push name.format
	# else
	rsc.formats = [name.format]

	paths = rsc.paths = {}
	for format in rsc.formats
		formatPaths = paths[format] = {}
		for resolution in rsc.resolutions
			resPath = "#{dirPath}/#{name.file}#{resolutionToString(resolution)}.#{format}"
			formatPaths[resolution] = resPath

	if rsc instanceof Resources.ImageResource
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
		parseResourcesObject val, dirPath, config

getFile = (path, config) ->
	unless fs.existsSync(path)
		log.error "File '#{path}' doesn't exist"
		return

	stat = fs.statSync path
	pathResourcesFile = pathUtils.join path, './resources.json'

	if stat.isDirectory()
		if fs.existsSync(pathResourcesFile)
			parseResourcesFile pathResourcesFile, config
		else
			parseResourcesFolder path, config
	else
		if isResourcesPath(path)
			parseResources path, config
		else
			parseResourceFile path, config

exports.parse = (path) ->
	getFile path, DEFAULT_CONFIG
