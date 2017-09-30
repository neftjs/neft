'use strict'

module.exports = (File) ->
    {Input} = File
    {Tag, Text} = File.Element
    InputRE = Input.RE

    (file) ->
        {node} = file

        # get inputs
        {inputs} = file

        forNode = (elem) ->
            # text
            if elem instanceof Text
                {text} = elem
                InputRE.lastIndex = 0
                if text and InputRE.test(text)
                    if funcBody = Input.parse(text)
                        `//<production>`
                        text = ''
                        `//</production>`
                        input = new Input.Text file, elem, text, funcBody
                        elem.text = ''
                        inputs.push input

            # props
            else if elem instanceof Tag
                for name, val of elem.props
                    if elem.props.hasOwnProperty(name) and Input.test(val)
                        if funcBody = Input.parse(val)
                            text = ''
                            `//<development>`
                            text = val
                            `//</development>`
                            input = new Input.Prop file, elem, text, funcBody, name
                            elem.props.set name, null
                            if name[0] is 'n' and name[1] is '-'
                                inputs.unshift input
                            else
                                inputs.push input

                for child in elem.children
                    forNode child
            return

        forNode node
