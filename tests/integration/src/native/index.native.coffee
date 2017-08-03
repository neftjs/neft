{callNativeFunction, onNativeEvent} = Neft.native

REQ_EVENT_NAME = 'testRequestEventName'
RESP_EVENT_NAME = 'testResponseEventName'

describe 'src/native', ->
    it 'calls and receives native communication', (callback) ->
        now = Date.now()
        onNativeEvent RESP_EVENT_NAME, (args...) ->
            try
                args[1] = args[1].toFixed(1)
                assert.isEqual args, [false, '108.4', 'ABC123', null]
            catch err
                callback err
                return
            callback()
        callNativeFunction REQ_EVENT_NAME, true, 54.2, 'abc123', null
