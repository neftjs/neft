'use strict'

exports.BINDING_THIS_TO_TARGET_OPTS = BINDING_THIS_TO_TARGET_OPTS = 1

repeatString = (str, amount) ->
    r = str
    for i in [0...amount-1] by 1
        r += str
    r

exports.isBinding = (code) ->
    try
        func = new Function 'console', "'use strict'; return #{code};"
        func.call null
        return false
    true

exports.parse = (val, isPublicId, opts=0, objOpts={}) ->
    binding = ['']

    # split to types
    val += ' '
    lastBinding = null
    isString = false
    for char, i in val
        if char is '.' and lastBinding
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

        if /'|"/.test(char) and val[i-1] isnt '\\'
            isString = not isString

    # filter by ids
    for elem, i in binding when typeof elem isnt 'string'
        [id] = elem
        if id is 'Renderer'
            elem.shift()
            [id] = elem
        if id is 'parent' or id is 'nextSibling' or id is 'previousSibling' or id is 'target' or objOpts.globalIdToThis?[id]
            elem.unshift "this"
        else if opts & BINDING_THIS_TO_TARGET_OPTS and id is 'this'
            elem.splice 1, 0, 'target'
        else if isPublicId(id) and (i is 0 or binding[i-1][binding[i-1].length - 1] isnt '.')
            continue
        else
            binding[i] = elem.join '.'

    # split texts
    i = -1
    n = binding.length
    while ++i < n
        if typeof binding[i] is 'string'
            if typeof binding[i-1] is 'string'
                binding[i-1] += binding[i]

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
            if binding[i-1]? and text
                text += ", "

            text += repeatString('[', elem.length-1)
            text += "'#{elem[0]}'"
            if elem[0] is "this"
                hash += "this"
            else
                hash += "#{elem[0]}"
            elem.shift()
            for id, i in elem
                text += ", '#{id}']"
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
