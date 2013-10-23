"use strict"

class Atoms.Core.Route extends Atoms.Core.Module

  @extend Atoms.Core.EventEmitter

  @routess: []

  @options: {}

  constructor: (@path, @callback) ->
    @names = []

    if typeof path is 'string'
      namedParam.lastIndex = 0
      while (match = namedParam.exec(path)) != null
        @names.push(match[1])

      splatParam.lastIndex = 0
      while (match = splatParam.exec(path)) != null
        @names.push(match[1])

      path = path.replace(escapeRegExp, '\\$&')
                 .replace(namedParam, '([^\/]*)')
                 .replace(splatParam, '(.*?)')

      @route = new RegExp('^' + path + '$')
    else
      @route = path


  @routes: (routes) ->
    # @add path, @proxy(callback) for path, callback of routes
    @add path, callback for path, callback of routes


  @listen: () ->
    Atoms.$(window).bind "popstate", @change
    @change()

  @unbind: ->
    Atoms.$(window).unbind "popstate", @change

  @navigate: (args...) ->
    options = {}
    last_argument = args[args.length - 1]
    if typeof last_argument is 'object'
      options = args.pop()
      options = @extend @options, options

    path = args.join('/')
    unless path is @path
      console.log "cambiar", path
      @path = path
      @trigger "navigate", @path
      @matchRoute(@path, options) if options.trigger
      history.pushState {}, document.title, @path
    @


  @add: (path, callback) ->
    if (typeof path is 'object' and path not instanceof RegExp)
      @add(key, value) for key, value of path
    else
      @routes.push(new @(path, callback))

  # Private
  @extend: (object={}, properties) ->
    object[key] = val for key, val of properties
    object

  @getPath: ->
    path = window.location.pathname
    if path.substr(0,1) isnt '/'
      path = '/' + path
    path

  @change: ->
    path = @getPath()
    unless path is @path
      @path = path
      @matchRoute(@path)
    @

  @matchRoute: (path, options) ->
    for route in @routes
      if route.match(path, options)
        @trigger 'change', route, path
        return route

  match: (path, options = {}) ->
    match = @route.exec(path)

    return false unless match

    options.match = match
    if @names.length
      for param, i in match.slice(1)
        options[@names[i]] = param

    @callback.call(null, options) isnt false

# Regular expressions
namedParam   = /:([\w\d]+)/g
splatParam   = /\*([\w\d]+)/g
escapeRegExp = /[-[\]{}()+?.,\\^$|#\s]/g

# # Coffee-script bug
# Atoms.Core.Route.change =
#   Atoms.Core.Route.proxy(Atoms.Core.Route.change)

# Atoms.Core.Class.Organism.include
#   route: (path, callback) ->
#     Atoms.Core.Route.add path, @proxy(callback)

#   routes: (routes) ->
#     @route(key, value) for key, value of routes

#   url: ->
#     Atoms.Core.Route.navigate.apply(Atoms.Core.Route, arguments)
