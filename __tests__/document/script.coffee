'use strict'

{createView, renderParse} = require './utils'

describe 'Document script', ->
    it 'is not rendered', ->
        view = createView '''
            <script></script>
        '''

        renderParse view
        assert.is view.element.stringify(), ''

    it 'is disabled if contains unknown HTML attributes', ->
        view = createView '''
            <script type="text">
                this.a = Math.random();
            </script>
        '''

        renderParse view
        assert.is view.exported.a, undefined

    it 'is called with props in beforeRender', ->
        view = createView '''
            <n-props a />
            <script>
            module.exports = {
                b: null,
                onRender() {
                    this.b = this.a
                },
            }
            </script>
        '''

        renderParse view,
            props:
                a: 1
        assert.is view.exported.b, 1

    it 'is called with refs in exported', ->
        view = createView '''
            <script>
            module.exports = {
                a: null,
                onRender() {
                    this.a = this.refs.x.props.a
                }
            }
            </script>
            <b n-ref="x" a='1' />
        '''

        renderParse view
        assert.is view.exported.a, '1'

    it 'is called with file node in exported', ->
        view = createView '''
            <script>
            module.exports = {
                aNode: null,
                onRender() {
                    this.aNode = this.node
                }
            }
            </script>
        '''

        renderParse view
        assert.is view.exported.aNode, view.node

    it 'predefined exported properties are not enumerable', ->
        view = createView '''
            <script>
            module.exports = {
                keys: null,
                onRender() {
                    var keys = [];
                    this.keys = keys;
                    for (var key in this) {
                        keys.push(key);
                    }
                },
            }
            </script>
        '''

        renderParse view
        assert.isEqual view.exported.keys, ['keys', 'onRender']

    it 'further tags are ignored', ->
        view = createView '''
            <script>
            module.exports = {
                aa: 1,
            }
            </script>
            <script>
            module.exports = {
                bb: 1,
            }
            </script>
        '''

        renderParse view
        {exported} = view
        assert.isEqual Object.keys(exported), ['aa']

    it 'can contains XML text', ->
        view = createView """
            <script>
            module.exports = {
                a: null,
                onRender() {
                    this.a = '<&&</b>'
                },
            }
            </script>
            ${this.a}
        """

        renderParse view
        assert.is view.element.stringify(), '<&&</b>'

    it 'properly calls events', ->
        view = createView """
            <script>
            module.exports = () => ({
                events: [],
                onRender() {
                    this.events.push('onRender');
                },
                onRevert() {
                    this.events.push('onRevert');
                },
            })
            </script>
        """

        view.render()
        {events} = view.exported
        assert.isEqual events, ['onRender']

        view.revert()
        assert.isEqual events, ['onRender', 'onRevert']

    it 'onRender is called with context in exported', ->
        view = createView '''
            <script>
            module.exports = {
                a: null,
                onRender() {
                    this.a = this.context.a
                },
            }
            </script>
        '''

        renderParse view, context: a: 1
        assert.is view.exported.a, 1

    it 'does not call events for foreign exported', ->
        view = createView """
            <script>
            module.exports = () => ({
                events: [],
                onRender() {
                    this.events.push('onRender');
                },
                onRevert() {
                    this.events.push('onRevert');
                },
            })
            </script>
            <ul n-each="${[1,2]}">${item}</ul>
        """

        view.render()
        {events} = view.exported
        assert.isEqual events, ['onRender']

        view.revert()
        assert.isEqual events, ['onRender', 'onRevert']
