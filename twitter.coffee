ntwitter = require 'ntwitter'

exports.Twitter = class Twitter

    @twit = new ntwitter
      consumer_key: 'NoHNk7oinaAnfZq8QznNyA'
      consumer_secret: 'tvHO8IrhbJUlEW9iA1ec0FuZWmrPmZlRRkCaChtjmK0'
      access_token_key: '15458624-Wt6dDAc5on7M9vkfbztTZU7WElBU2aGDYuUCXHSM'
      access_token_secret: 'NHWGgA4XCrHkDSVlTfzKpJWizhOdaEsIsCOXJPPhTs'

    @start: (socket) ->
      Twitter.twit.stream 'user', {track: 'node'}, (stream) ->
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

    @update: (tweet) ->
      console.log "tweet is #{tweet}"
      Twitter.twit.updateStatus tweet.tweet, (err, data) ->
        console.log err
        console.log data
