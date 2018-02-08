'use strict'

{createView, renderParse} = require './utils.server'

describe 'Document <n-when />', ->
    it 'calls on each change', ->
        source = createView '''
            <n-when change="${props.name}" call="${this.changed(1)}" />
            <script>
            this.changed = (plus) => {
                this.state.set('counter', this.state.counter + plus)
            }

            this.defaultState = { counter: 0 }
            </script>
        '''
        view = source.clone()

        renderParse view, props: name: 'a'
        assert.is view.inputState.counter, 0

        view.inputProps._set 'name', 'b'
        assert.is view.inputState.counter, 1

        view.inputProps._set 'name', 'a'
        assert.is view.inputState.counter, 2
