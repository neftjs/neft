'use strict'

{Dict, List} = Neft
{createView, renderParse} = require './utils.server'

describe 'Document string interpolation', ->
    describe '`props`', ->
        it 'lookup component', ->
            source = createView '''
                <component name="a" x="2">${props.x}</component>
                <use component="a" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '2'

        it 'is accessible by scope', ->
            source = createView '''
                <component name="a" x="2">
                    ${this.props.x}
                </component>
                <use component="a" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '2'

        it 'lookup use', ->
            source = createView '''
                <component name="a" x="1">${props.x}</component>
                <use component="a" x="2" />
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '2'

        it 'always keeps proper sources order', ->
            source = createView '''
                <component name="a" x="1">
                    <component name="b" x="1">
                        ${props.x}
                    </component>
                    <use component="b" x="4" />
                </component>
                <use component="a" x="3" />
            '''
            view = source.clone()

            renderParse view

            useA = view.node.children[0]
            componentA = useA.children[0]
            useB = componentA.children[0]
            componentB = useB.children[0]
            assert.is view.node.stringify(), '4'

            componentA.props.set 'x', -1
            useA.props.set 'x', -1
            componentB.props.set 'x', -1
            assert.is view.node.stringify(), '4'

            componentA.props.set 'x', 1
            useA.props.set 'x', 3
            componentB.props.set 'x', 1

            useB.props.set 'x', undefined
            assert.is view.node.stringify(), '1'

            useA.props.set 'x', undefined
            assert.is view.node.stringify(), '1'

            componentB.props.set 'x', 2
            assert.is view.node.stringify(), '2'

            componentA.props.set 'x', 3
            assert.is view.node.stringify(), '2'

            componentA.props.set 'x', undefined
            assert.is view.node.stringify(), '2'

    describe '`refs`', ->
        it 'refers to nodes', ->
            source = createView '''
                <a ref="first" label="12" visible="false" />
                ${refs.first.props.label}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '12'

            view.node.children[0].props.set 'label', 23
            assert.is view.node.stringify(), '23'

        it 'are accessible by scope', ->
            source = createView '''
                <a ref="first" label="12" visible="false" />
                ${this.refs.first.props.label}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '12'

            view.node.children[0].props.set 'label', 23
            assert.is view.node.stringify(), '23'

        it 'refers to used components', ->
            source = createView '''
                <component name="a">
                    <script>
                        this.onRender(function () {
                            this.state.set('name', 'a');
                        });
                        this.update = function () {
                            this.state.set('name', 'b');
                        };
                    </script>
                </component>
                <a ref="first" />
                ${refs.first.state.name}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), 'a'

            view.inputRefs.first.update()
            assert.is view.node.stringify(), 'b'

    it 'file `refs` are not accessed in components', ->
        source = createView '''
            <a ref="first" label="12" visible="false" />
            <component name="a">
                ${typeof refs.first}
            </component>
            <use component="a" />
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

        it 'is accesible by scope', ->
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
                <component name="a">${context.a}</component>
                <use component="a" />
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
                    this.onRender(function(){
                        this.state.set('a', 1);
                    });
                </script>
                ${state.a}
            '''
            view = source.clone()

            renderParse view
            assert.is view.node.stringify(), '1'

        it 'is accessible by scope', ->
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

        it 'binding is not updated on reverted component', ->
            source = createView '''
                <script>
                    this.onRender(function(){
                        this.state.set('obj', { a: 1 });
                    });
                </script>
                ${state.obj.a || '0'}
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

    it 'returned handler is called on signal with scope and parameters', ->
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
        it 'is called with proper scope and parameters', ->
            source = createView '''
                <prop name="y" value="3" />
                <span
                  x="1"
                  ref="a1"
                  onPropsChange="${context.test(refs.a1.props.x, props.y)}"
                />
            '''
            view = source.clone()

            calls = 0
            renderParse view,
                storage:
                    test: (x, y) ->
                        calls += 1
                        assert.is x, 2
                        assert.is y, 3

            view.node.query('span').props.set 'x', 2
            assert.is calls, 1

        it 'is not called if the document is not rendered', ->
            source = createView '''
                <prop name="y" value="3" />
                <span x="1" ref="a1" onPropsChange="${context.onPropsChange()}" />
            '''
            view = source.clone()

            calls = 0
            renderParse view,
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
                <component name="a">${props.x}</component>
                <use component="a" x="2" y="1" />
            '''
            view = source.clone()
            elem = view.node.children[0]

            renderParse view
            elem.props.set 'x', 1
            assert.is view.node.stringify(), '1'

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
                <component name="a">${context.a}</component>
                <use component="a" />
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
