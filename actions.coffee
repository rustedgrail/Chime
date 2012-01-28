logins = require './logins'

exports.Actions = class Actions

  @login: (args) ->
    if logins[args.username] == args.password
      "./views/success.html"
    else
      "./views/denied.html"
