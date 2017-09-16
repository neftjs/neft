'use strict'

nmlAst = require './nmlAst'

exports.getQueries = (objects) ->
    queries = {}
    queryCache = {}

    byObject = (object, ids) ->
        if object.id
            ids = [ids..., object.id]
        if Array.isArray(object.body)
            byObject child, ids for child in object.body
        else if Array.isArray(object.value?.body)
            byObject object.value, ids
        else if object.type is nmlAst.ATTRIBUTE_TYPE and object.name is 'query'
            query = object.value.slice(1, -1)
            if ids.length > 1
                parentQuery = ''
                for index in [ids.length - 2..0] by -1
                    if parentQuery = queryCache[ids[index]]
                        break
                if parentQuery
                    query = "#{parentQuery} #{query}"
            queryCache[ids[ids.length - 1]] = query
            queries[query] = do ->
                if ids.length > 1
                    "#{ids[0]}:#{ids[ids.length - 1]}"
                else
                    ids[0]

    byObject object, [] for object in objects
    queries
