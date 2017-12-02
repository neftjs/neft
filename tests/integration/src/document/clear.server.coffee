'use strict'

{createView} = require './utils.server'

describe 'Document HTML file parse cleaner', ->
    it 'removes blank spaces and new lines from texts', ->
        view = createView '''<span>
            ABC
        </span>'''

        text = view.render().node.children[0].children[0].text
        assert.is text, 'ABC'

    it 'does not removes white spaces from inline text', ->
        view = createView '''<span> ABC </span>'''

        text = view.render().node.children[0].children[0].text
        assert.is text, ' ABC '

    it 'removes blank texts', ->
        view = createView '''<span>
        </span>'''

        assert.is view.render().node.children[0].children.length, 0
