'use strict'

{Schema} = Neft
SchemaError = Schema.Error

describe 'schema', ->
    it 'only provided rows in the schema can be saved', ->
        SCHEMA =
            first: {}
        DOC =
            noProvided: 2

        try
            new Schema(SCHEMA).validate DOC
        catch err

        assert.instanceOf err, SchemaError
        assert.is err.message, 'Unexpected noProvided property'

    it 'sub properties are validated properly', ->
        SCHEMA =
            first:
                type: 'object'
            'first.second':
                type: 'boolean'

        DOC =
            first:
                second: 2

        err = null

        try
            new Schema(SCHEMA).validate DOC
        catch err

        assert.instanceOf err, SchemaError
        assert.is err.message, 'first.second must be a boolean'

    it 'sub property arrays are validated properly', ->
        SCHEMA =
            first:
                type: 'object'
                array: true
                optional: true
            'first[]':
                type: 'boolean'

        DOC =
            first: [true, 2]

        err = null

        try
            new Schema(SCHEMA).validate DOC
        catch err

        assert.instanceOf err, SchemaError
        assert.is err.message, 'first[] must be a boolean'

    it 'sub property array properties are validated properly', ->
        SCHEMA =
            first:
                type: 'object'
                array: true
                optional: true
            'first[]':
                type: 'object'
            'first[].second':
                type: 'boolean'

        DOC =
            first: [{second: true}, {second: 2}]

        err = null

        try
            new Schema(SCHEMA).validate DOC
        catch err

        assert.instanceOf err, SchemaError
        assert.is err.message, 'first[].second must be a boolean'
