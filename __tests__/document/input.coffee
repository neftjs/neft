'use strict'

{Struct, ObservableArray} = require '@neftio/core'
{createView, renderParse} = require './utils'

describe 'Document string interpolation', ->
    it 'works in a text', ->
        view = createView '''
            Hello {$context.name}!
        '''

        renderParse view,
            context: name: 'Max'
        assert.is view.element.stringify(), 'Hello Max!'

    it 'may contain expression code', ->
        view = createView '''
            <b visible="{$context.page !== 'Loading'}" />
        '''
        context = new Struct page: 'Loading'
        renderParse view,
            context: context
        tag = view.element.query 'b'
        assert.is tag.props.visible, false

        context.page = 'Welcome'
        assert.is tag.props.visible, true

    describe '`props`', ->
        it 'lookup use', ->
            view = createView '''
                <n-component name="a">
                    {x}
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="2" />
            '''

            renderParse view
            assert.is view.element.stringify(), '2'

        it 'always keeps proper sources order', ->
            view = createView '''
                <n-component name="a">
                    <n-component name="b">
                        {x}
                        <n-props x />
                    </n-component>
                    <n-use n-component="b" x="4" />
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="3" />
            '''

            renderParse view

            useA = view.element.children[0]
            componentA = useA.children[0]
            useB = componentA.children[0]
            componentB = useB.children[0]
            assert.is view.element.stringify(), '4'

            useA.props.set 'x', -1
            assert.is view.element.stringify(), '4'

            useA.props.set 'x', 3
            useB.props.set 'x', undefined
            assert.is view.element.stringify(), ''

            useA.props.set 'x', undefined
            assert.is view.element.stringify(), ''

        it 'does not contain internal properties', ->
            view = createView '''
                <n-component name="a">
                    {Object.keys(this)}
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="1" n-if={true} />
            '''

            renderParse view
            assert.is view.element.stringify(), 'x'

        return

    describe '`refs`', ->
        it 'refers to nodes', ->
            view = createView '''
                <a n-ref="first" label="12" />
                {$refs.first.props.label}
            '''

            renderParse view
            assert.is view.element.children[1].text, '12'

            view.element.children[0].props.set 'label', 23
            assert.is view.element.children[1].text, '23'

        it 'can be defined without n- prefix', ->
            view = createView '''
                <a ref="first" label="12" />
                {$refs.first.props.label}
            '''

            renderParse view
            assert.is view.element.children[1].text, '12'

        it 'are accessible by exported', ->
            view = createView '''
                <a n-ref="first" label="12" />
                {this.$refs.first.props.label}
            '''

            renderParse view
            assert.is view.element.children[1].text, '12'

            view.element.children[0].props.set 'label', 23
            assert.is view.element.children[1].text, '23'

        it 'refers to used components', ->
            view = createView '''
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
                {$refs.first && $refs.first.name}
            '''

            renderParse view
            assert.is view.element.stringify(), 'a'

            view.exported.$refs.first.update()
            assert.is view.element.stringify(), 'b'

        return

    it 'file `refs` are not accessed in components', ->
        view = createView '''
            <div n-ref="first" label="12" />
            <n-component name="Test">
                {typeof $refs.first}
            </n-component>
            <n-use n-component="Test" />
        '''

        renderParse view
        assert.is view.element.children[1].stringify(), 'undefined'

    describe '`$context`', ->
        it 'is accessed in rendered file', ->
            view = createView '''
                {$context.a}
            '''

            renderParse view,
                context: a: '1'
            assert.is view.element.stringify(), '1'

            view.revert()
            renderParse view,
                context: a: '2'
            assert.is view.element.stringify(), '2'

        it 'is accesible by exported', ->
            view = createView '''
                {this.$context.a}
            '''

            renderParse view,
                context: a: '1'
            assert.is view.element.stringify(), '1'

            view.revert()
            renderParse view,
                context: a: '2'
            assert.is view.element.stringify(), '2'

        it 'lookup use', ->
            view = createView '''
                <n-component name="a">{$context.a}</n-component>
                <n-use n-component="a" />
            '''

            renderParse view,
                context: a: '1'
            assert.is view.element.stringify(), '1'

            view.revert()
            renderParse view,
                context: a: '2'
            assert.is view.element.stringify(), '2'

        it 'lookup n-for', ->
            view = createView '''
                <blank n-for="item in {[1]}">
                    {$context.a}
                </blank>
            '''

            renderParse view,
                context: a: '1'
            assert.is view.element.stringify(), '1'

            view.revert()
            renderParse view,
                context: a: '2'
            assert.is view.element.stringify(), '2'

        return

    describe '`state`', ->
        it 'is accessed in rendered file', ->
            view = createView '''
                <script>
                exports.default = {
                    a: 0,
                    onRender() {
                        this.a = 1
                    },
                }
                </script>
                {a}
            '''

            renderParse view
            assert.is view.element.stringify(), '1'

        it 'is accessible by exported', ->
            view = createView '''
                <script>
                exports.default = {
                    a: 0,
                    onRender() {
                        this.a = 1
                    },
                }
                </script>
                {this.a}
            '''

            renderParse view
            assert.is view.element.stringify(), '1'

        it 'is cleared on revert', ->
            view = createView '''
                <script>
                exports.default = {
                    a: 0,
                    onRender() {
                        this.a = this.a + 1
                    },
                }
                </script>
                {a}
            '''

            renderParse view
            assert.is view.element.stringify(), '1'

            view.revert()
            renderParse view
            assert.is view.element.stringify(), '1'

        it 'binding is not updated on reverted component', ->
            view = createView '''
                <script>
                exports.default = {
                    obj: null,
                    onRender() {
                        this.obj = { a: 1 }
                    },
                }
                </script>
                {obj.a || '0'}
            '''

            renderParse view

            view.revert()
            assert.is view.element.stringify(), '1'
            view.render()
            assert.is view.element.stringify(), '1'

        return

    it 'handler is called on signal', ->
        view = createView '''
            <span x="1" onClick="{$context.onClick(2)}" />
        '''

        calls = 0
        renderParse view,
            context:
                onClick: (val) ->
                    calls += 1
                    assert.is val, 2

        view.element.children[0].props.onClick()
        assert.is calls, 1

    it 'returned handler is called on signal with exported and parameters', ->
        view = createView '''
            <span x="1" onClick="{$context.onClick}" />
        '''

        calls = 0
        renderParse view,
            context:
                onClick: ->
                    calls += 1

        view.element.children[0].props.onClick()
        assert.is calls, 1

    describe 'support real-time changes', ->
        it 'on `props`', ->
            view = createView '''
                <n-component name="a">
                    {x}
                    <n-props x />
                </n-component>
                <n-use n-component="a" x="2" y="1" />
            '''
            elem = view.element.children[0]

            renderParse view
            elem.props.set 'x', 1
            assert.is view.element.stringify(), '1'

        it 'on `props` list element', ->
            view = createView '''
                <n-component name="a">
                    {list[0]}
                    <n-props list />
                </n-component>
                <n-use n-component="a" list="{$context.list}" />
            '''
            elem = view.element.children[0]
            list = new ObservableArray()

            renderParse view,
                context:
                    list: list
            list.push 'a'
            assert.is view.element.stringify(), 'a'

        it 'on `context`', ->
            view = createView '{$context.x}'

            context = new Struct x: 1

            renderParse view,
                context: context
            assert.is view.element.stringify(), '1'

            context.x = 2
            assert.is view.element.stringify(), '2'

        it 'on `context` property', ->
            view = createView '{$context.dict.x}'

            context = dict: new Struct x: 1

            renderParse view,
                context: context
            assert.is view.element.stringify(), '1'

            context.dict.x = 2
            assert.is view.element.stringify(), '2'

        it 'on `context` use', ->
            view = createView '''
                <n-component name="a">{$context.a}</n-component>
                <n-use n-component="a" />
            '''

            renderParse view,
                context: context = new Struct a: '1'

            context.a = 2
            assert.is view.element.stringify(), '2'

        it 'on `context` n-for', ->
            view = createView '''
                <blank n-for="item in {[1]}">
                    {$context.a}
                </blank>
            '''

            renderParse view,
                context: context = new Struct a: '1'

            context.a = 2
            assert.is view.element.stringify(), '2'

        return

    return
