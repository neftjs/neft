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

    it 'is called with props in onRender', ->
        view = createView '''
            <n-props a />
            <script>
            exports.default = {
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

    it 'is called with $refs in exported', ->
        view = createView '''
            <script>
            exports.default = {
                a: null,
                onRender() {
                    this.a = this.$refs.x.props.a
                }
            }
            </script>
            <b n-ref="x" a='1' />
        '''

        renderParse view
        assert.is view.exported.a, '1'

    it 'is called with file $element in exported', ->
        view = createView '''
            <script>
            exports.default = {
                savedElement: null,
                onRender() {
                    this.savedElement = this.$element
                }
            }
            </script>
        '''

        renderParse view
        assert.is view.exported.savedElement, view.element

    it 'predefined exported properties are not enumerable', ->
        view = createView '''
            <script>
            exports.default = {
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
            exports.default = {
                aa: 1,
            }
            </script>
            <script>
            exports.default = {
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
            exports.default = {
                a: null,
                onRender() {
                    this.a = '<&&</b>'
                },
            }
            </script>
            {this.a}
        """

        renderParse view
        assert.is view.element.stringify(), '<&&</b>'

    it 'properly calls events', ->
        view = createView """
            <script>
            exports.default = () => ({
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

    it 'onRender is called with $context in exported', ->
        view = createView '''
            <script>
            exports.default = {
                a: null,
                onRender() {
                    this.a = this.$context.a
                },
            }
            </script>
        '''

        renderParse view, context: a: 1
        assert.is view.exported.a, 1

    it 'does not call events for foreign exported', ->
        view = createView """
            <script>
            exports.default = () => ({
                events: [],
                onRender() {
                    this.events.push('onRender');
                },
                onRevert() {
                    this.events.push('onRevert');
                },
            })
            </script>
            <ul n-for="item in {[1,2]}">{item}</ul>
        """

        view.render()
        {events} = view.exported
        assert.isEqual events, ['onRender']

        view.revert()
        assert.isEqual events, ['onRender', 'onRevert']

    it 'is combined with static methods', ->
        view = createView '''
            <script>
            exports.plusOne = num => num + 1
            exports.default = () => ({
                numbers: [1, 2]
            })
            </script>
            <p n-for="number in {numbers}">{plusOne(number)},</p>
        '''

        view.render()

        assert.is view.element.stringify(), '<p>2,3,</p>'

    return
