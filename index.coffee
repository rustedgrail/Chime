http = require('http')
io = require('socket.io')

Routes = require('./routes').Routes
Twitter = require('./twitter').Twitter

exports.Server = class Server

  @onRequest: (request, response) ->
    path = Routes.getPath request.url
    Routes.writeResponse path, response

  @start: ->
    port = process.env.PORT || 8888
    app = http.createServer(@onRequest)
    socket = io.listen(app)
    app.listen port

    Twitter.start socket

    socket.sockets.on 'connection', (socket) ->
      socket.emit 'tweet',
        tweet: 'hello'

Server.start()
