$ ->
  # class Url extends Atoms.Core.Route

  #   constructor: ->
  #     super
  #     @routes
  #       "/:context/:subcontext" : @_subcontext
  #       "/:context"             : @_context
  #       "/"                     : @_index

  #   _subcontext: (parameters) -> console.log "_subcontext", parameters
  #   _context: (parameters) -> console.log "_context", parameters
  #   _index: (parameters) -> console.log "_index", parameters

  # url = new Url()

  # url = Atoms.$(window)
  # url.bind "popstate", (args...) ->
  #   console.log "popstate", args

  #   path = window.location.pathname
  #   if path.substr(0,1) isnt '/'
  #     path = '/' + path
  #   console.log "path >>> ", path

  # # window.history.pushState {}, null, "funciona/sdsd"
