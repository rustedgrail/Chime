Routes = require('../routes').Routes

describe 'the routing framework', ->
  it 'can get a file extension', ->
    ext = Routes.getExtension 'favicon.ico'
    expect(ext).toBe "ico"

  it 'can find the root path', ->
    path = Routes.getPath '/'
    expect(path).toBe './views/index.html'

  it 'can return a 404 page', ->
    path = Routes.getPath '/ThisPageWillNeverExists.Exist'
    expect(path).toBe './views/404.html'

  it 'can return a static page', ->
    path = Routes.getPath '/index.html'
    expect(path).toBe './views/index.html'

  it 'can call a function and get a page', ->
    path = Routes.getPath '/login.html?username=chime&password=chime'
    expect(path).toBe './views/login.html'
