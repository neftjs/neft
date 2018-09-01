'use strict'

{Dict, List} = Neft
{createView, renderParse} = require './utils.server'

describe 'Document string interpolation', ->
    describe '`props`', ->
        it 'lookup use', ->
            source = createView '''
                <n-component name="a">
                    ${x}
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="2" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '2'

        it 'always keeps proper sources order', ->
            source = createView '''
                <n-component name="a">
                    <n-component name="b">
                        ${x}
                        <n-props x />
                    </n-component>
                    <n-use n-component="b" x="4" />
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="3" />
            '''
            view = source.clone()

            renderParse view

            useA = view.node.children[0]
            componentA = useA.children[0]
            useB = componentA.children[0]
            componentB = useB.children[0]
            assert.is view.node.stringify(), '4'

            useA.props.set 'x', -1
            assert.is view.node.stringify(), '4'

            useA.props.set 'x', 3
            useB.props.set 'x', undefined
            assert.is view.node.stringify(), ''

            useA.props.set 'x', undefined
            assert.is view.node.stringify(), ''

        it 'does not contain internal properties', ->
            source = createView '''
                <n-component name="a">
                    ${Object.keys(this)}
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="1" n-style="renderer:Rectangle" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), 'x'

    describe '`refs`', ->
        it 'refers to nodes', ->
            source = createView '''
                <a n-ref="first" label="12" visible="false" />
                ${refs.first.props.label}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '12'

            view.node.children[0].props.set 'label', 23
            assert.is view.node.stringify(), '23'

        it 'are accessible by exported', ->
            source = createView '''
                <a n-ref="first" label="12" visible="false" />
                ${this.refs.first.props.label}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '12'

            view.node.children[0].props.set 'label', 23
            assert.is view.node.stringify(), '23'

        it 'refers to used components', ->
            source = createView '''
                <n-component name="Test">
                    <script>
                    exports.default = {
                        name: '',
                        onRender() {
                            this.name = 'a'
                        },
                        update() {
                            this.name = 'b'
                        },
                    }
                    </script>
                </n-component>
                <Test n-ref="first" />
                ${refs.first && refs.first.name}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), 'a'

            view.inputRefs.first.update()
            assert.is view.node.stringify(), 'b'

    it 'file `refs` are not accessed in components', ->
        source = createView '''
            <div n-ref="first" label="12" visible="false" />
            <n-component name="Test">
                ${typeof refs.first}
            </n-component>
            <n-use n-component="Test" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), 'undefined'

    describe '`context`', ->
        it 'is accessed in rendered file', ->
            source = createView '''
                ${context.a}
            '''
            view = source.clone()

            renderParse view,
                storage: a: '1'
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view,
                storage: a: '2'
            assert.is view.node.stringify(), '2'

        it 'is accesible by exported', ->
            source = createView '''
                ${this.context.a}
            '''
            view = source.clone()

            renderParse view,
                storage: a: '1'
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view,
                storage: a: '2'
            assert.is view.node.stringify(), '2'

        it 'lookup use', ->
            source = createView '''
                <n-component name="a">${context.a}</n-component>
                <n-use n-component="a" />
            '''
            view = source.clone()

            renderParse view,
                storage: a: '1'
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view,
                storage: a: '2'
            assert.is view.node.stringify(), '2'

        it 'lookup n-each', ->
            source = createView '''
                <blank n-each="[1]">
                    ${context.a}
                </blank>
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
                exports.default = {
                    a: 0,
                    onRender() {
                        this.a = 1
                    },
                }
                </script>
                ${a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '1'

        it 'is accessible by exported', ->
            source = createView '''
                <script>
                exports.default = {
                    a: 0,
                    onRender() {
                        this.a = 1
                    },
                }
                </script>
                ${this.a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '1'

        it 'is cleared on revert', ->
            source = createView '''
                <script>
                exports.default = {
                    a: 0,
                    onRender() {
                        this.a = this.a + 1
                    },
                }
                </script>
                ${a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '1'

            view.revert()
            renderParse view
            assert.is view.node.stringify(), '1'

        it 'binding is not updated on reverted component', ->
            source = createView '''
                <script>
                exports.default = {
                    obj: null,
                    onRender() {
                        this.obj = { a: 1 }
                    },
                }
                </script>
                ${obj.a || '0'}
            '''
            view = source.clone()

            renderParse view

            view.revert()
            assert.is view.node.stringify(), '1'
            view.render()
            assert.is view.node.stringify(), '1'

    it 'handler is called on signal', ->
        source = createView '''
            <span x="1" onPropsChange="${context.onPropsChange(2)}" />
        '''
        view = source.clone()

        calls = 0
        renderParse view,
            storage:
                onPropsChange: (val) ->
                    calls += 1
                    assert.is val, 2

        view.node.children[0].props.set 'x', 2
        assert.is calls, 1

    it 'returned handler is called on signal with exported and parameters', ->
        source = createView '''
            <span x="1" onPropsChange="${context.onPropsChange}" />
        '''
        view = source.clone()

        calls = 0
        renderParse view,
            storage:
                onPropsChange: (prop, oldVal) ->
                    calls += 1
                    assert.is @, view.node.children[0]
                    assert.is prop, 'x'
                    assert.is oldVal, 1

        view.node.children[0].props.set 'x', 2
        assert.is calls, 1

    describe 'prop handler', ->
        it 'is called with proper exported and parameters', ->
            source = createView '''
                <span
                  x="1"
                  n-ref="a1"
                  onPropsChange="${context.test(refs.a1.props.x, y)}"
                />
                <n-props y />
            '''
            view = source.clone()

            calls = 0
            renderParse view,
                props:
                    y: 3
                storage:
                    test: (x, y) ->
                        calls += 1
                        assert.is x, 2
                        assert.is y, 3

            view.node.query('span').props.set 'x', 2
            assert.is calls, 1

        it 'is not called if the document is not rendered', ->
            source = createView '''
                <span x="1" n-ref="a1" onPropsChange="${context.onPropsChange()}" />
            '''
            view = source.clone()

            calls = 0
            renderParse view,
                props:
                    y: 3
                storage:
                    onPropsChange: (x, y) ->
                        calls += 1

            view.node.query('span').props.set 'x', 4
            assert.is calls, 1

            view.revert()
            view.node.query('span').props.set 'x', 2
            assert.is calls, 1

    describe 'support real-time changes', ->
        it 'on `props`', ->
            source = createView '''
                <n-component name="a">
                    ${x}
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="2" y="1" />
            '''
            view = source.clone()
            elem = view.node.children[0]

            renderParse view
            elem.props.set 'x', 1
            assert.is view.node.stringify(), '1'

        it 'on `props` list element', ->
            source = createView '''
                <n-component name="a">
                    ${list[0]}
                    <n-props list />
                </n-component>
                <n-use n-component="a" list="List()" />
            '''
            view = source.clone()
            elem = view.node.children[0]

            renderParse view
            elem.props.list.append 'a'
            assert.is view.node.stringify(), 'a'

        it 'on `context`', ->
            source = createView '${context.x}'
            view = source.clone()

            storage = new Dict x: 1

            renderParse view,
                storage: storage
            assert.is view.node.stringify(), '1'

            storage.set 'x', 2
            assert.is view.node.stringify(), '2'

        it 'on `context` property', ->
            source = createView '${context.dict.x}'
            view = source.clone()

            storage = dict: new Dict x: 1

            renderParse view,
                storage: storage
            assert.is view.node.stringify(), '1'

            storage.dict.set 'x', 2
            assert.is view.node.stringify(), '2'

        it 'on `context` use', ->
            source = createView '''
                <n-component name="a">${context.a}</n-component>
                <n-use n-component="a" />
            '''
            view = source.clone()

            renderParse view,
                storage: storage = new Dict a: '1'

            storage.set 'a', 2
            assert.is view.node.stringify(), '2'

        it 'on `context` n-each', ->
            source = createView '''
                <blank n-each="[1]">
                    ${context.a}
                </blank>
            '''
            view = source.clone()

            renderParse view,
                storage: storage = new Dict a: '1'

            storage.set 'a', 2
            assert.is view.node.stringify(), '2'

    describe 'global object', ->
        beforeEach ->
            global.abc = 123

        afterEach ->
            delete global.abc

        it 'is accessible', ->
            source = createView '${global.abc}'
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '123'

        it 'contains Neft object', ->
            source = createView '${typeof global.Neft.utils.NOP}'
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), 'function'

        it 'accesses Neft object directly', ->
            source = createView '${typeof Neft.utils.NOP}'
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), 'function'
