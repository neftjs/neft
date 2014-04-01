'use strict'

[Routing, fs] = ['routing', 'fs'].map require

module.exports = (App) -> new class DevModel extends App.Model.Client().View()

    App.View.fromHTML 'dev', '<!doctype html><meta charset=utf-8"><script src="app.js">'

    @view 'dev',
    @client Routing.GET, 'app',
    getAppHtml: (id, query, type, callback) ->

        callback null

    @client Routing.GET, 'app.js',
    getAppJs: (id, query, type, callback) ->

        callback null, fs.readFileSync './build/bundles/browser.js', 'utf-8'
