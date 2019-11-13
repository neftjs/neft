nmlParser = require './'

transform = (nml) ->
    ast = nmlParser.getAST nml
    for object in ast.objects
        nmlParser.transformNamespaceSetters object
    ast

it 'transforms margin with 4 numeric values', ->
    ast = transform '''
    @Item {
        margin: '1 2.2 3 4'
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.top', value: 1 },
        { type: 'attribute', name: 'margin.right', value: 2.2 },
        { type: 'attribute', name: 'margin.bottom', value: 3 },
        { type: 'attribute', name: 'margin.left', value: 4 },
    ])

it 'transforms margin with 3 numeric values', ->
    ast = transform '''
    @Item {
        margin: '1 2.2 3'
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.top', value: 1 },
        { type: 'attribute', name: 'margin.right', value: 2.2 },
        { type: 'attribute', name: 'margin.bottom', value: 3 },
        { type: 'attribute', name: 'margin.left', value: 2.2 },
    ])

it 'transforms margin with 2 numeric values', ->
    ast = transform '''
    @Item {
        margin: '1 2.2'
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.top', value: 1 },
        { type: 'attribute', name: 'margin.right', value: 2.2 },
        { type: 'attribute', name: 'margin.bottom', value: 1 },
        { type: 'attribute', name: 'margin.left', value: 2.2 },
    ])

it 'transforms margin with numeric value written as string', ->
    ast = transform '''
    @Item {
        margin: '1.1'
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.top', value: 1.1 },
        { type: 'attribute', name: 'margin.right', value: 1.1 },
        { type: 'attribute', name: 'margin.bottom', value: 1.1 },
        { type: 'attribute', name: 'margin.left', value: 1.1 },
    ])

it 'transforms margin with numeric value', ->
    ast = transform '''
    @Item {
        margin: 1.1
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.top', value: 1.1 },
        { type: 'attribute', name: 'margin.right', value: 1.1 },
        { type: 'attribute', name: 'margin.bottom', value: 1.1 },
        { type: 'attribute', name: 'margin.left', value: 1.1 },
    ])

it 'transforms nested margin with numeric value', ->
    ast = transform '''
    @Item {
        margin: 1

        @Rectangle {
            margin: 2
        }
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.top', value: 1 },
        { type: 'attribute', name: 'margin.right', value: 1 },
        { type: 'attribute', name: 'margin.bottom', value: 1 },
        { type: 'attribute', name: 'margin.left', value: 1 },
        { type: 'object', id: '_i0', name: 'Rectangle', body: [
            { type: 'attribute', name: 'margin.top', value: 2 },
            { type: 'attribute', name: 'margin.right', value: 2 },
            { type: 'attribute', name: 'margin.bottom', value: 2 },
            { type: 'attribute', name: 'margin.left', value: 2 },
        ] }
    ])

it 'transforms margin with binding', ->
    ast = transform '''
    @Item {
        margin: 12 / 2
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.top', value: '12 / 2' },
        { type: 'attribute', name: 'margin.right', value: 'this.margin.left' },
        { type: 'attribute', name: 'margin.bottom', value: 'this.margin.left' },
        { type: 'attribute', name: 'margin.left', value: 'this.margin.left' },
    ])

it 'transforms padding with binding', ->
    ast = transform '''
    @Item {
        padding: 12 / 2
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'padding.top', value: '12 / 2' },
        { type: 'attribute', name: 'padding.right', value: 'this.padding.left' },
        { type: 'attribute', name: 'padding.bottom', value: 'this.padding.left' },
        { type: 'attribute', name: 'padding.left', value: 'this.padding.left' },
    ])

it 'transforms alignment with string', ->
    ast = transform '''
    @Item {
        alignment: 'center'
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'alignment.horizontal', value: "'center'" },
        { type: 'attribute', name: 'alignment.vertical', value: "'center'" },
    ])

it 'transforms alignment with binding', ->
    ast = transform '''
    @Item {
        alignment: VAL
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'alignment.horizontal', value: "VAL" },
        { type: 'attribute', name: 'alignment.vertical', value: 'this.alignment.horizontal' },
    ])

it 'transforms margin with nested properties', ->
    ast = transform '''
    @Item {
        margin: {
            left: 4
            top: 5
        }
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'margin.left', value: '4' },
        { type: 'attribute', name: 'margin.top', value: '5' },
    ])

it 'transforms any field with nested properties', ->
    ast = transform '''
    @Item {
        customField: {
            first: 1.1
            second: 'red'
        }
    }
    '''
    expect(ast.objects[0].body).toEqual([
        { type: 'attribute', name: 'customField.first', value: '1.1' },
        { type: 'attribute', name: 'customField.second', value: "'red'" },
    ])
