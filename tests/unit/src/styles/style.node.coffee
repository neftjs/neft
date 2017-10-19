'use strict'

{List} = Neft
{Style} = Neft.Document

describe 'style', ->
    describe 'syncClassProp()', ->
        beforeEach ->
            @item = classes: List()
            @testMethod = -> Style::syncClassProp.apply item: @item, arguments

        it 'adds new classes', ->
            @testMethod 'a b c', ''
            assert.isEqual @item.classes.toArray(), ['a', 'b', 'c']

        it 'cleans existing classes', ->
            @item.classes.extend ['a', 'b', 'c']
            @testMethod '', 'a c'
            assert.isEqual @item.classes.toArray(), ['b']

        it 'replaces classes', ->
            @item.classes.extend ['a', 'b']
            @testMethod 'c d', 'a b'
            assert.isEqual @item.classes.toArray(), ['c', 'd']

        it 'changes first class', ->
            @item.classes.extend ['a', 'b', 'c']
            @testMethod '1 b c', 'a b c'
            assert.isEqual @item.classes.toArray(), ['1', 'b', 'c']

        it 'changes middle class', ->
            @item.classes.extend ['a', 'b', 'c']
            @testMethod 'a 1 c', 'a b c'
            assert.isEqual @item.classes.toArray(), ['a', '1', 'c']

        it 'changes last class', ->
            @item.classes.extend ['a', 'b', 'c']
            @testMethod 'a b 1', 'a b c'
            assert.isEqual @item.classes.toArray(), ['a', 'b', '1']

        it 'changes middle class with duplications', ->
            @item.classes.extend ['a', 'b', 'c']
            @testMethod 'a 1 c', 'a b b c'
            assert.isEqual @item.classes.toArray(), ['a', '1', 'c']

        it 'changes duplicated middle class', ->
            @item.classes.extend ['a', 'b', 'c']
            @testMethod 'a 1 c 1', 'a b c'
            assert.isEqual @item.classes.toArray(), ['a', 'c', '1']

        it 'changes classes in order', ->
            @item.classes.extend ['a', 'b']
            @testMethod 'b a', 'a b'
            assert.isEqual @item.classes.toArray(), ['b', 'a']

        it 'removes duplicates', ->
            @testMethod 'a a', 'b a'
            assert.isEqual @item.classes.toArray(), ['a']
