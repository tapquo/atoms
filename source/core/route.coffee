"use strict"


Atoms.Url = do ->

  regexp =
    attributes: /:([\w\d]+)/g
    splat     : /\*([\w\d]+)/g
    escape    : /[-[\]{}()+?.,\\^$|#\s]/g
    hash      : /^#*/

  history = false
  routes = {}
  current = null

  _listen = (urls) ->
    _addRoute(path, callback) for path, callback of urls
    Atoms.$(window).on "popstate", _change

  _path = (args...) ->
    last_argument = args[args.length - 1]
    if typeof last_argument is 'object'
      options = args.pop()

    path = "/" + args.join("/")
    unless path is current
      path = "#" + path unless history
      window.history.pushState {}, document.title, path.toLowerCase()
      _change()

  _back = ->
    window.history.back()


  _forward = ->
    window.history.forward()


  # Private
  _addRoute = (path, callback) ->
    attributes = ["url"]

    regexp.attributes.lastIndex = 0
    while (match = regexp.attributes.exec(path)) != null
      attributes.push(match[1])

    regexp.splat.lastIndex = 0
    while (match = regexp.splat.exec(path)) != null
      attributes.push(match[1])

    path = path.replace(regexp.escape, '\\$&')
               .replace(regexp.attributes, '([^\/]*)')
               .replace(regexp.splat, '(.*?)')

    console.log path, attributes

    routes[path] =
      attributes: attributes
      callback  : callback
      regexp    : new RegExp('^' + path + '$')


  _change = (event) ->
    if event then event.preventDefault()
    path = if history then _getPath() else _getFragment()

    console.log "\n[history]", history.state
    console.log "  -[path]", path

    unless path is current
      current = path
      _matchRoute path


  _getPath = ->
    path = window.location.pathname
    if path.substr(0,1) isnt '/'
      path = '/' + path
    path

  _getFragment = ->
    window.location.hash.replace(regexp.hash, '')


  _matchRoute = (path, options) ->
    console.log "  -[matchRoute]", path
    for key of routes
      route = routes[key]
      exec = route.regexp.exec(path)
      if exec
        obj = {}
        obj[attribute] = exec[index] for attribute, index in route.attributes
        route.callback?.call(@, obj)
        break

  return {
    listen  : _listen
    path    : _path
    back    : _back
    forward : _forward
    add     : _addRoute
  }




Atoms.Url.listen
  ""                   : (properties) -> console.error "callback /", properties
  "/:article/:section" : (properties) ->
    console.error "callback /article/section", properties
    Atoms.System.Layout.show properties.article, properties.section

