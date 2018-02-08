'use strict'

{createView, renderParse} = require './utils.server'

describe 'Document <n-state />', ->
    it 'sets value under state property', ->
        source = createView '''
            <n-state name="a" value="1" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.inputState.a, 1

    it 'set value is available before render', ->
        source = createView '''
            <n-state name="a" value="1" />
            <script>
                this.onBeforeRender(() => {
                    this.stateA = this.state.a;
                });
            </script>
        '''
        view = source.clone()

        renderParse view
        assert.is view.scope.stateA, 1

    it 'value is set always before render', ->
        source = createView '''
            <n-state name="a" value="1" />
        '''
        view = source.clone()

        renderParse view
        view.inputState.set 'a', 2

        view.revert()
        view.render()
        assert.is view.inputState.a, 1

    it 'value is set only when state node is visible', ->
        source = createView '''
            <n-state name="a" value="1" n-if="${props.visible}" />
            <script>
                this.defaultState = {
                    a: 2
                };
            </script>
        '''
        view = source.clone()

        renderParse view,
            props:
                visible: false
        assert.is view.inputState.a, 2

        view.inputProps._set 'visible', true
        assert.is view.inputState.a, 1

    it 'value is set after defaultState', ->
        source = createView '''
            <n-state name="a" value="1" />
            <script>
                this.defaultState = {
                    a: 2
                };
            </script>
        '''
        view = source.clone()

        renderParse view
        assert.is view.inputState.a, 1
