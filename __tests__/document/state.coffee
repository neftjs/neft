{Struct} = require '@neft/core'
{createView, renderParse} = require './utils'

describe '<n-state />', ->
    it 'creates new state attribute', ->
        view = createView """
            <n-state name="userName" value="Bob" />
            <h1>{userName}</h1>
        """
        view.render()
        assert.isEqual view.element.stringify(), '<h1>Bob</h1>'

    it 'value is optional', ->
        view = createView """
            <n-state name="userName" />
            <n-call>{userName = 'Bob'}</n-call>
            <h1>{userName}</h1>
        """
        view.render()
        assert.isEqual view.element.stringify(), '<h1>Bob</h1>'

    it 'value can be a binding', ->
        view = createView """
            <n-prop name="config" />
            <n-state name="userName" value={config.givenUserName} />
            <h1>{userName}</h1>
        """
        config = new Struct givenUserName: 'Bob'
        view.render({props: {config}})
        assert.isEqual view.element.stringify(), '<h1>Bob</h1>'

        config.givenUserName = 'Max'
        assert.isEqual view.element.stringify(), '<h1>Max</h1>'

    it 'onChange is called with an old value', ->
        view = createView """
            <n-prop name="config" />
            <n-state name="values" value={[]} />
            <n-state
                name="userName"
                value={config.givenUserName}
                onChange="{oldVal => { values = [...values, oldVal] }}"
            />
            <h1>{values}</h1>
        """
        config = new Struct givenUserName: 'Bob'
        view.render({props: {config}})
        assert.isEqual view.element.stringify(), '<h1></h1>'

        config.givenUserName = 'Max'
        assert.isEqual view.element.stringify(), '<h1>Bob</h1>'

    return
