###
HTML5 API History Wrapper

@namespace Atoms.Core
@class Route

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Url = do (a = Atoms) ->

  regexp =
    attributes  : /:([\w\d]+)/g
    splat       : /\*([\w\d]+)/g
    escape      : /[-[\]{}()+?.,\\^$|#\s]/g
    hash        : /^#*/

  history       = false
  routes        = {}
  current_path  = null
  forward       = true

  ###
  @TODO
  @method path
  @param  {value}    Array of urls with callbacks
  ###
  _path = (args...) ->
    forward = true
    path = "/" + args.join("/")
    unless path is current_path
      path = "#" + path unless history
      state = window.history.state or null
      window.history.pushState state, document.title, path.toLowerCase()
      _change()

  ###
  @TODO
  @method back
  ###
  _back = ->
    forward = false
    steps = if window.history.state.steps? then window.history.state.steps else 1
    window.history.go -steps

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

    routes[path] =
      attributes: attributes
      callback  : callback
      regexp    : new RegExp('^' + path + '$')

  _change = (event) ->
    if event then event.preventDefault()
    path = if history then _getPath() else _getFragment()

    unless path is current_path
      current_path = path
      _matchRoute path

  _getPath = ->
    path = window.location.pathname
    if path.substr(0,1) isnt '/'
      path = '/' + path
    path

  _getFragment = ->
    window.location.hash.replace(regexp.hash, '')

  _matchRoute = (path, options) ->
    for key of routes
      route = routes[key]
      exec = route.regexp.exec(path)
      if exec
        obj = {}
        obj[attribute] = exec[index] for attribute, index in route.attributes
        route.callback?.call(@, obj)
        break

  _pushState = (properties) ->
    if forward
      Atoms.System.Layout.show properties.article, properties.section
    else
      Atoms.System.Layout.back properties.article, properties.section

  _listen = do ->
    _addRoute "/:article/:section", _pushState
    Atoms.$(window).on "popstate", _change

  return {
    path    : _path
    back    : _back
    add     : _addRoute
  }
