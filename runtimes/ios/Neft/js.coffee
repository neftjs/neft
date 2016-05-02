@_createOnCompletion = (id) ->
    (data) ->
        _neft.postMessage "response",
            id: id
            response: data
        return
