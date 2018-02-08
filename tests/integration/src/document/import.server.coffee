'use strict'

{createView, renderParse, uid} = require './utils.server'

describe 'Document n-import', ->
    it 'is not rendered', ->
        first = "namespace#{uid()}"
        view1 = createView '', first
        view2 = createView "<n-import href=\"#{first}\" />"
        view2 = view2.clone()

        renderParse view2
        assert.is view2.node.stringify(), ''

    describe 'components from external file', ->
        it 'without namespace', ->
            first = "namespace#{uid()}"
            view1 = createView '<n-component n-name="a">1</n-component>', first
            view2 = createView """
                <n-import href="#{first}" />
                <a />
            """
            view2 = view2.clone()

            renderParse view2
            assert.is view2.node.stringify(), '1'

        it 'with namespace', ->
            first = uid()
            view1 = createView '<n-component n-name="a">1</n-component>', first
            view2 = createView """
                <n-import href="#{first}" as="ns">
                <ns:a />
            """
            view2 = view2.clone()

            renderParse view2
            assert.is view2.node.stringify(), '1'

    describe 'external file', ->
        it 'with namespace', ->
            first = uid()
            view1 = createView '''
                <n-component n-name="a">1</n-component>
                file<a />2
            ''', first
            view2 = createView """
                <n-import href="#{first}" as="ns">
                <ns />
            """
            view2 = view2.clone()

            renderParse view2
            assert.is view2.node.stringify(), 'file12'
