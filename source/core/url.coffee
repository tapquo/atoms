###
HTML5 API History Wrapper

@namespace Atoms
@class Url

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Url = do (a = Atoms) ->

  _regexp =
    attributes  : /:([\w\d]+)/g
    splat       : /\*([\w\d]+)/g
    escape      : /[-[\]{}()+?.,\\^$|#\s]/g
    hash        : /^#*/

  _options =
    path   : null
    forward: true
    history: false
    routes : {}

  _article = undefined

  ###
  @TODO
  @method path
  @param  {value}    Array of urls with callbacks
  ###
  _path = (args...) ->
    _options.forward = true
    path = "/" + args.join("/")
    unless path is _options.path
      path = "#" + path unless _options.history
      state = window.history.state or null
      window.history.pushState state, document.title, path.toLowerCase()
      _onPopState()

  ###
  @TODO
  @method back
  ###
  _back = ->
    _options.forward = false
    steps = if window.history.state.steps? then window.history.state.steps else 1
    window.history.go -steps

  ###
  @TODO
  @method listen
  ###
  _listen = (path, callback) ->
    attributes = ["url"]
    _regexp.attributes.lastIndex = 0
    while (match = _regexp.attributes.exec(path)) != null
      attributes.push(match[1])

    _regexp.splat.lastIndex = 0
    while (match = _regexp.splat.exec(path)) != null
      attributes.push(match[1])

    path = path.replace(_regexp.escape, '\\$&')
               .replace(_regexp.attributes, '([^\/]*)')
               .replace(_regexp.splat, '(.*?)')

    _options.routes[path] =
      attributes: attributes
      callback  : callback
      regexp    : new RegExp('^' + path + '$')

  # Private
  _onPopState = (event) ->
    if event then event.preventDefault()
    path = if _options.history then _getPath() else _getFragment()
    unless path is _options.path
      _options.path = path
      _matchRoute path

  _getPath = ->
    path = window.location.pathname
    if path.substr(0,1) isnt '/'
      path = '/' + path
    path

  _getFragment = ->
    window.location.hash.replace(_regexp.hash, '')

  _matchRoute = (path, options) ->
    for key of _options.routes
      route = _options.routes[key]
      exec = route.regexp.exec(path)
      if exec
        obj = {}
        obj[attribute] = exec[index] for attribute, index in route.attributes
        route.callback?.call(@, obj)
        break

  _onChangeArticleSection = (properties) ->
    article = a.App.Article[a.Core.Helper.className(properties.article)]
    unless _options.forward then _stepHistory 0
    _activeSection article, properties.section
    if _article isnt article
      if _options.forward
        _stepHistory 1
        article.state("in")
        _article.state("back-in") if _article
      else
        _article.state("out")
        article.state("back-out")
      _article = article

  _aside = ->
    _article.aside()

  _activeSection = (article, section) ->
    _addStepHistory()
    article.el.children("section##{section}")
      .addClass("active")
      .siblings().removeClass("active")

  _addStepHistory = ->
    state = window.history.state or steps: 0
    state.steps++
    window.history.replaceState state

  _stepHistory = (value) ->
    window.history.replaceState steps: value

  do ->
    _listen "/:article/:section", _onChangeArticleSection
    Atoms.$(window).on "popstate", _onPopState

  path    : _path
  back    : _back
  listen  : _listen
  aside   : _aside
