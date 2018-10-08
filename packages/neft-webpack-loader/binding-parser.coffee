'use strict'

exports.BINDING_THIS_TO_TARGET_OPTS = BINDING_THIS_TO_TARGET_OPTS = 1<<0
exports.BINDING_THIS_TO_SELF_OPTS = BINDING_THIS_TO_SELF_OPTS = 1<<1

repeatString = (str, amount) ->
    r = str
    for i in [0...amount - 1] by 1
        r += str
    r

isArrayElementIndexer = (string, index) ->
    if string[index] isnt '['
        return false
    while index++ < string.length
        char = string[index]
        if char is ']'
            return true
        unless /[0-9]/.test(char)
            return false
    false

exports.isBinding = (code) ->
    try
        func = new Function 'console', "'use strict'; return #{code};"
        func.call null
        return false
    true

exports.parse = (val, isPublicId, opts = 0, objOpts = {}, isVariableId) ->
    isVariableId ?= -> false
    binding = ['']

    # split to types
    val += ' '
    lastBinding = null
    isString = false
    isArrayIndexer = false
    for char, i in val
        if isArrayIndexer and char is ']'
            isArrayIndexer = false
            continue

        isCurrentArrayIndexer = not isString and isArrayElementIndexer(val, i)
        if (char is '.' or isCurrentArrayIndexer) and lastBinding
            isArrayIndexer = isCurrentArrayIndexer
            lastBinding.push ''
            continue

        if lastBinding and (isString or ///[a-zA-Z_0-9$]///.test(char))
            lastBinding[lastBinding.length - 1] += char
        else if ///[a-zA-Z_$]///.test(char)
            lastBinding = [char]
            binding.push lastBinding
        else
            if lastBinding is null
                binding[binding.length - 1] += char
            else
                lastBinding = null
                binding.push char

        if char in ['\'', '"'] and val[i - 1] isnt '\\'
            isString = not isString

    # filter by ids
    for elem, i in binding when typeof elem isnt 'string'
        elem = objOpts.modifyBindingPart?(elem) or elem
        if opts & BINDING_THIS_TO_SELF_OPTS and elem[0] is 'this'
            elem.splice 1, 0, 'self'
        useThis = elem[0] in ['parent', 'nextSibling', 'previousSibling', 'target']
        useThis or= objOpts.globalIdToThis?[elem[0]]
        useThis or= objOpts.shouldPrefixByThis?(elem[0])
        if useThis
            elem.unshift "this"
        if opts & BINDING_THIS_TO_TARGET_OPTS and elem[0] is 'this'
            elem.splice 1, 0, 'target'
        if isPublicId(elem[0]) and (i is 0 or binding[i - 1][binding[i - 1].length - 1] isnt '.')
            continue
        else
            binding[i] = elem.join '.'

    # split texts
    i = -1
    n = binding.length
    while ++i < n
        if typeof binding[i] is 'string'
            if typeof binding[i - 1] is 'string'
                binding[i - 1] += binding[i]

            else if binding[i].trim() isnt ''
                continue

            binding.splice i, 1
            n--

    # split
    text = ''
    hash = ''
    for elem, i in binding
        if typeof elem is 'string'
            hash += elem
        else if elem.length > 1
            if binding[i - 1]? and text
                text += ", "

            text += repeatString('[', elem.length - 1)
            if isVariableId(elem[0])
                text += "#{elem[0]}"
            else
                text += "'#{elem[0]}'"
            if elem[0] is "this"
                hash += "this"
            else
                hash += "#{elem[0]}"
            elem.shift()
            for id, i in elem
                text += ", '#{id}']"
                if isFinite(id)
                    hash += "[#{id}]"
                else
                    hash += ".#{id}"
        else
            if elem[0] is "this"
                hash += "this"
            else
                hash += "#{elem[0]}"

    hash = hash.trim()
    text = text.trim()

    hash: hash
    connections: text