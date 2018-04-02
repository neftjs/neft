@_createOnCompletion = (id) ->
    (data) ->
        ios.postMessage "response",
            id: id
            response: data
        return
