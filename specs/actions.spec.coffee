Actions = require('../actions').Actions

describe 'routing actions', ->
  it 'can match a login', ->
    loggedIn = Actions.login
      username: "chime"
      password: "chime"
    expect(loggedIn).toBe './views/success.html'

  it 'rejects bad usernames', ->
    loggedIn = Actions.login
      username: "Sir Not Appearing"
      password: "chime"
    expect(loggedIn).toBe './views/denied.html'

  it 'rejects bad passwords', ->
    loggedIn = Actions.login
      username: "chime"
      password: "Not a Password"
    expect(loggedIn).toBe './views/denied.html'
