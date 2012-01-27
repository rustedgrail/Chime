ntwitter = require 'ntwitter'

exports.Twitter = class Twitter

  constructor: () -> 
      
    @twit = new ntwitter
      consumer_key: 'NoHNk7oinaAnfZq8QznNyA'
      consumer_secret: 'tvHO8IrhbJUlEW9iA1ec0FuZWmrPmZlRRkCaChtjmK0'
      access_token_key: '15458624-aN67VlF0CgUMkJ92Eu3HaRnJiHmWjnM4yWchn9wpn'
      access_token_secret: 'PmEEABgaYRv8tft31gXjIwqHcsBO74cYpduaCScW21c'

    @twit.stream 'statuses/sample', (stream) ->
      console.log "stream"
      stream.on 'data', (data) ->
        
        console.log "data"
        console.log(data)

      stream.on 'end', (response) ->
        console.log response
        console.log "end"
        # Handle a disconnection

      stream.on 'destroy', (response) ->
        console.log "destroy"
        # Handle a 'silent' disconnection from Twitter, no end/error event fired

      # Disconnect stream after five seconds
      #setTimeout(stream.destroy, 5000);



new Twitter()
