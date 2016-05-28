'use strict'

{assert, Dict, List, unit} = Neft
{describe, it} = unit
{createView, renderParse} = require './utils'

describe 'src/document string interpolation', ->
    describe '`attrs`', ->
        it 'lookup neft:fragment', ->
            source = createView '''
                <neft:fragment neft:name="a" x="2">${attrs.x}</neft:fragment>
                <neft:use neft:fragment="a" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '2'

        it 'is accessible by context', ->
            source = createView '''
                <neft:fragment neft:name="a" x="2">
                    ${this.attrs.x}
                </neft:fragment>
                <neft:use neft:fragment="a" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '2'

        it 'lookup neft:use', ->
            source = createView '''
                <neft:fragment neft:name="a" x="1">${attrs.x}</neft:fragment>
                <neft:use neft:fragment="a" x="2" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '2'

        it 'always keeps proper sources order', ->
            source = createView '''
                <neft:fragment neft:name="a" x="1">
                    <neft:fragment neft:name="b" x="1">
                        ${attrs.x}
                    </neft:fragment>
                    <neft:use neft:fragment="b" x="4" />
                </neft:fragment>
                <neft:use neft:fragment="a" x="3" />
            '''
            view = source.clone()

            renderParse view

            useA = view.node.children[0]
            fragmentA = useA.children[0]
            useB = fragmentA.children[0]
            fragmentB = useB.children[0]
            assert.is view.node.stringify(), '4'

            fragmentA.attrs.set 'x', -1
            useA.attrs.set 'x', -1
            fragmentB.attrs.set 'x', -1
            assert.is view.node.stringify(), '4'

            fragmentA.attrs.set 'x', 1
            useA.attrs.set 'x', 3
            fragmentB.attrs.set 'x', 1

            useB.attrs.set 'x', undefined
            assert.is view.node.stringify(), '1'

            useA.attrs.set 'x', undefined
            assert.is view.node.stringify(), '1'

            fragmentB.attrs.set 'x', 2
            assert.is view.node.stringify(), '2'

            fragmentA.attrs.set 'x', 3
            assert.is view.node.stringify(), '2'

            fragmentA.attrs.set 'x', undefined
            assert.is view.node.stringify(), '2'

    describe '`ids`', ->
        it 'refers to nodes', ->
            source = createView '''
                <a id="first" label="12" visible="false" />
                ${ids.first.attrs.label}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '12'

            view.node.children[0].attrs.set 'label', 23
            assert.is view.node.stringify(), '23'

        it 'is accessible by context', ->
            source = createView '''
                <a id="first" label="12" visible="false" />
                ${this.ids.first.attrs.label}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '12'

            view.node.children[0].attrs.set 'label', 23
            assert.is view.node.stringify(), '23'

    it 'file `ids` are accessed in fragments', ->
        source = createView '''
            <a id="first" label="12" visible="false" />
            <neft:fragment neft:name="a">
                ${ids.first.attrs.label}
            </neft:fragment>
            <neft:use neft:fragment="a" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '12'

        view.node.children[0].attrs.set 'label', 23
        assert.is view.node.stringify(), '23'

    describe '`root`', ->
        it 'is accessed in rendered file', ->
            source = createView '''
                ${root.a}
            '''
            view = source.clone()

            renderParse view,
                storage: a: '1'
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view,
                storage: a: '2'
            assert.is view.node.stringify(), '2'

        it 'is accesible by context', ->
            source = createView '''
                ${this.root.a}
            '''
            view = source.clone()

            renderParse view,
                storage: a: '1'
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view,
                storage: a: '2'
            assert.is view.node.stringify(), '2'

        it 'lookup neft:use', ->
            source = createView '''
                <neft:fragment neft:name="a">${root.a}</neft:fragment>
                <neft:use neft:fragment="a" />
            '''
            view = source.clone()

            renderParse view,
                storage: a: '1'
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view,
                storage: a: '2'
            assert.is view.node.stringify(), '2'

        it 'lookup neft:each', ->
            source = createView '''
                <neft:blank neft:each="[1]">
                    ${root.a}
                </neft:blank>
            '''
            view = source.clone()

            renderParse view,
                storage: a: '1'
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view,
                storage: a: '2'
            assert.is view.node.stringify(), '2'

    describe '`state`', ->
        it 'is accessed in rendered file', ->
            source = createView '''
                <script>
                    this.onRender(function(){
                        this.state.set('a', 1);
                    });
                </script>
                ${state.a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '1'

        it 'is accesible by context', ->
            source = createView '''
                <script>
                    this.onRender(function(){
                        this.state.set('a', 1);
                    });
                </script>
                ${this.state.a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '1'

        it 'is cleared on revert', ->
            source = createView '''
                <script>
                    this.onRender(function(){
                        this.state.set('a', (this.state.a || 0) + 1);
                    });
                </script>
                ${state.a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view
            assert.is view.node.stringify(), '1'

        it 'is not accessible in not rendered document', ->
            source = createView '''
                <script>
                    this.onCreate(function(){
                        this.a = !!this.state;
                    });
                </script>
                ${this.a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), 'false'

    it 'handler is called on signal', ->
        source = createView '''
            <span x="1" onAttrsChange="${root.onAttrsChange(2)}" />
        '''
        view = source.clone()

        calls = 0
        renderParse view,
            storage:
                onAttrsChange: (val) ->
                    calls += 1
                    assert.is val, 2

        view.node.children[0].attrs.set 'x', 2
        assert.is calls, 1

    it 'returned handler is called on signal with context and parameters', ->
        source = createView '''
            <span x="1" onAttrsChange="${root.onAttrsChange}" />
        '''
        view = source.clone()

        calls = 0
        renderParse view,
            storage:
                onAttrsChange: (prop, oldVal) ->
                    calls += 1
                    assert.is this, view.node.children[0]
                    assert.is prop, 'x'
                    assert.is oldVal, 1

        view.node.children[0].attrs.set 'x', 2
        assert.is calls, 1

    it 'attribute handler is called with proper context and parameters', ->
        source = createView '''
            <neft:attr name="y" value="3" />
            <span x="1" id="a1" onAttrsChange="${root.onAttrsChange(ids.a1.attrs.x, attrs.y)}" />
        '''
        view = source.clone()

        calls = 0
        renderParse view,
            storage:
                onAttrsChange: (x, y) ->
                    calls += 1
                    assert.is x, 2
                    assert.is y, 3

        view.node.query('span').attrs.set 'x', 2
        assert.is calls, 1

    it 'attribute handler is not called if the document is not rendered', ->
        source = createView '''
            <neft:attr name="y" value="3" />
            <span x="1" id="a1" onAttrsChange="${root.onAttrsChange()}" />
        '''
        view = source.clone()

        calls = 0
        renderParse view,
            storage:
                onAttrsChange: (x, y) ->
                    calls += 1

        view.node.query('span').attrs.set 'x', 4
        assert.is calls, 1

        view.revert()
        view.node.query('span').attrs.set 'x', 2
        assert.is calls, 1

    describe 'support realtime changes', ->
        it 'on `attrs`', ->
            source = createView '''
                <neft:fragment neft:name="a">${attrs.x}</neft:fragment>
                <neft:use neft:fragment="a" x="2" y="1" />
            '''
            view = source.clone()
            elem = view.node.children[0]

            renderParse view
            elem.attrs.set 'x', 1
            assert.is view.node.stringify(), '1'

        it 'on `root`', ->
            source = createView "${root.x}"
            view = source.clone()

            storage = new Dict x: 1

            renderParse view,
                storage: storage
            assert.is view.node.stringify(), '1'

            storage.set 'x', 2
            assert.is view.node.stringify(), '2'

        it 'on `root` property', ->
            source = createView "${root.dict.x}"
            view = source.clone()

            storage = dict: new Dict x: 1

            renderParse view,
                storage: storage
            assert.is view.node.stringify(), '1'

            storage.dict.set 'x', 2
            assert.is view.node.stringify(), '2'

        it 'on `root` neft:use', ->
            source = createView '''
                <neft:fragment neft:name="a">${root.a}</neft:fragment>
                <neft:use neft:fragment="a" />
            '''
            view = source.clone()

            renderParse view,
                storage: storage = new Dict a: '1'

            storage.set 'a', 2
            assert.is view.node.stringify(), '2'

        it 'on `root` neft:each', ->
            source = createView '''
                <neft:blank neft:each="[1]">
                    ${root.a}
                </neft:blank>
            '''
            view = source.clone()

            renderParse view,
                storage: storage = new Dict a: '1'

            storage.set 'a', 2
            assert.is view.node.stringify(), '2'
