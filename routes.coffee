fs = require 'fs'
path = require 'path'
url = require 'url'

Actions = require('./actions').Actions
FileTypes = require('./fileTypes')

exports.Routes = class Routes

  @getPath: (rawUrl) ->
    parsedUrl = url.parse(rawUrl, true)
    console.log "URL #{rawUrl}"

    if parsedUrl.pathname == '/'
      './views/index.html'
    else if Actions[parsedUrl.pathname]
      Actions[parsedUrl.pathname](parsedUrl.query)
    else if path.existsSync "./views#{parsedUrl.pathname}"
      "./views#{parsedUrl.pathname}"
    else
      './views/404.html'

  @writeResponse: (path, response) ->
    fs.readFile path, (err, data) ->
      try
        console.log "Writing #{path}"
        contentType = FileTypes[Routes.getExtension(path)]
        response.writeHead 200,
          "Content-Type": contentType
          "Content-Length": data.length
        response.write data
        response.end
      catch err
        console.log "Trying to reach #{path}"
        console.log err

  @getExtension: (path) ->
    parts = path.split '.'
    parts[parts.length - 1]
