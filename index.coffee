"use strict"

http = require 'http'
url = require 'url'
fs = require 'fs'
io = require('socket.io')

Twitter = require('./twitter').Twitter

exports.Server = class Server

  @onRequest: (request, response) ->
    logins = 
      login: "asd"
      password: "asd"

    currentUrl = url.parse(request.url, true)
    if currentUrl.pathname == '/'
      file = './views/index.html'
    else if currentUrl.pathname == "/login.html"
      if currentUrl.query.login == logins.login && currentUrl.query.password == logins.password
        file = "./login.html"
        new Twitter(io)
      else
        file = "./error.html"
    else if currentUrl.pathname == "/socket.io/socket.io.js"
      console.log "serving socket"
      return
    else
      console.log "final"
      file = ".#{currentUrl.pathname}"

    fs.readFile file, (err, data) ->
      try
        if file.indexOf('ico') > -1
          contentType = "image/x-icon"
        else
          contentType = "text/html"

        console.log "reading file #{file}"
        response.writeHead 200,
          "Content-Type": contentType
          "Content-Length": data.length
        response.write data
        response.end
        console.log "End reading"
      catch err
        console.log "Trying to reach #{request.url}"
        console.log err

  @start: ->
    port = process.env.PORT || 8888
    app = http.createServer(@onRequest)
    socket = io.listen(app)
    app.listen port

    socket.sockets.on 'connection', (socket) ->
      socket.emit 'tweet', 
        tweet: 'hello'

Server.start()
