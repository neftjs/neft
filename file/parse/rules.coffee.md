neft:rule @xml
=========

```
<neft:rule query="input[type=string]">
  <attrs neft:style="styles:elements/form/input/string" />
</neft:rule>
```

	'use strict'

	utils = require 'utils'
	log = require 'log'

	log = log.scope 'Document', 'neft:rule'

	commands =
		'attrs': (command, node) ->
			for name, val of command._attrs
				unless node.attrs.has(name)
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

	isMainFileRule = (node) ->
		while node = node.parent
			if node.name isnt '' and node.name isnt 'neft:rule'
				return false
		true

	module.exports = (File) ->
		parseLinks = require('./fragments/links') File

		(file) ->
			rules = []
			utils.defineProperty file, '_rules', null, rules

			# get rules from this file
			localRules = file.node.queryAll 'neft:rule'
			localRules.sort (a, b) ->
				getNodeLength(b) - getNodeLength(a)

			for rule in localRules
				query = rule.attrs.get 'query'
				unless query
					log.error "neft:rule no 'query' attribute found"
					continue

				children = rule.children
				i = 0
				n = children.length
				while i < n
					child = children[i]
					if child.name is 'neft:rule'
						subquery = query + ' ' + child.attrs.get('query')
						child.attrs.set 'query', subquery
						child.parent = rule.parent
						n--
					else
						i++

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
					# load rules only from the mail file scope
					if isMainFileRule(externalRule)
						rules.push
							node: externalRule.node
							parent: file.node

			for rule in rules
				unless query = rule.node.attrs.get('query')
					continue

				nodes = rule.parent.queryAll query
				for node in nodes
					for command in rule.node.children
						enterCommand command, node

			return