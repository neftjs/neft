'use strict'

{createView, renderParse, uid} = require './utils.server'

describe '<n-log />', ->
    it 'is recognized and saved', ->
        view = createView '''
            <span />
            <div><n-log a="1" /></div>
        '''
        view = view.clone()

        assert.lengthOf view.logs, 1
        assert.is view.logs[0].node.props.a, 1

    it 'is not rendered', ->
        view = createView '''
            <div><n-log a="1">123</n-log></div>
        '''
        view = view.clone()

        assert.is view.node.stringify(), '<div></div>'
