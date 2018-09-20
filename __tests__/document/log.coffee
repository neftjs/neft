'use strict'

{createView, renderParse, uid} = require './utils'

describe '<n-log />', ->
    it 'is recognized and saved', ->
        view = createView '''
            <span />
            <div><n-log a="1" /></div>
        '''
        assert.lengthOf view.logs, 1
        assert.is view.logs[0].element.props.a, '1'

    it 'is not rendered', ->
        view = createView '''
            <div><n-log a="1">123</n-log></div>
        '''
        assert.is view.element.stringify(), '<div></div>'
