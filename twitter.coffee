ntwitter = require 'ntwitter'

exports.Twitter = class Twitter

    @twit = new ntwitter
      consumer_key: 'NoHNk7oinaAnfZq8QznNyA'
      consumer_secret: 'tvHO8IrhbJUlEW9iA1ec0FuZWmrPmZlRRkCaChtjmK0'
      access_token_key: '15458624-aN67VlF0CgUMkJ92Eu3HaRnJiHmWjnM4yWchn9wpn'
      access_token_secret: 'PmEEABgaYRv8tft31gXjIwqHcsBO74cYpduaCScW21c'

    @start: (socket) ->
      Twitter.twit.stream 'user', {track: 'fun'}, (stream) ->
        stream.on 'data', (data) ->
          text = data?.text
          user = data?.user?.screen_name
          socket.emit 'tweet', "#{text} tweeted by #{user}." if text? and user?

        stream.on 'end', (response) ->
          console.log response
          # Handle a disconnection

        stream.on 'destroy', (response) ->
          console.log "destroy"
          # Handle a 'silent' disconnection from Twitter, no end/error event fired
