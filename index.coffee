Routes = require('./routes').Routes
Twitter = require('./twitter').Twitter

onRequest = (request, response) ->
  console.log "Request #{request.url}"
  path = Routes.getPath request.url
  console.log "Path #{path}"
  Routes.writeResponse path, response

app = require('http').createServer onRequest
io = require('socket.io').listen app

port = process.env.PORT || 8888
app.listen port

io.sockets.on 'connection', (socket) ->
  #socket.emit 'tweet', 'test'
  Twitter.start socket
