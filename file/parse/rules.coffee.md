neft:rule
=========

	'use strict'

	utils = require 'utils'
	log = require 'log'

	log = log.scope 'Document', 'neft:rule'

	commands =
		'attrs': (command, node) ->
			for name, val of command._attrs
				unless node.attrs.has name
					node.attrs.set name, val
			return

	enterCommand = (command, node) ->
		unless commands[command.name]
			log.error "Rule '#{command.name}' not found"
			return

		commands[command.name] command, node
		return

	getNodeLength = (node) ->
		i = 0
		while node = node.parent
			i++
		i

	module.exports = (File) ->
		parseLinks = require('./fragments/links') File

		(file) ->
			rules = []
			utils.defineProperty file, '_rules', null, rules

			# get rules from this file
			localRules = file.node.queryAll 'neft:rule'
			localRules.sort (a, b) ->
				getNodeLength(b) - getNodeLength(a)
			for localRule in localRules
				rules.push
					node: localRule
					parent: localRule.parent
				localRule.parent = null

			# merge rules from files
			links = parseLinks file
			for link in links
				linkView = File.factory link.path
				for externalRule in linkView._rules
					rules.push
						node: externalRule.node
						parent: file.node

			for rule in rules
				query = rule.node.attrs.get 'query'
				unless query
					log.error "No 'query' attribute found"
					continue

				nodes = rule.parent.queryAll query
				for node in nodes
					for command in rule.node.children
						enterCommand command, node

			return