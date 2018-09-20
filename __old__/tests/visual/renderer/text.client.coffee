'use strict'

visual = require '../utils.client'

RESOURCES_TIMEOUT = 15000

checker = new visual.Checker
    prefix: 'renderer/text'
    styles: require './text.nml'

describe 'platform renderer properly', ->
    it 'loads resources', (end) ->
        loader = Neft.Renderer.ResourcesLoader.New
            resources: app.resources
        timeout = setTimeout ->
            end new Error "Cannot load resources; current progress = #{loader.progress}"
        , RESOURCES_TIMEOUT
        loader.onProgressChange ->
            if loader.progress is 1
                clearTimeout timeout
                end()

    # TODO: fix text rendering differences between platforms
    # describe 'renders text', ->
    #     checker.registerAll()
