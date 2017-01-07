'use strict'

{createView, renderParse, uid} = require './utils.server'

describe '<log />', ->
    it 'is recognized and saved', ->
        view = createView '''
            <span />
            <div><log a="1" /></div>
        '''
        view = view.clone()

        assert.lengthOf view.logs, 1
        assert.is view.logs[0].node.props.a, 1
