###
Base class for Atom

@namespace Atoms
@class BaseAtom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.BaseAtom extends Atoms.Module

  @include Atoms.EventEmitter

  molecule: null
  template: null

  constructor: (@attributes) ->
    super
    @type = "Atom"
    if @attributes?.molecule? and @template?
      @molecule = Atoms.$ @attributes.molecule
      if @attributes.method? then @render(@attributes.method) else @append()

    @bindEvents @events if @events?
    @el

  # Event handling
  bindEvents: (events) ->
    for evt in events
      event_name = "atom-#{@className.toLowerCase()}#{Atoms.className(evt)}"
      @el.on evt, do (event_name) => (event) => @trigger event_name, event, @

  # Output methods
  append: -> @render "append"

  prepend: -> @render "prepend"

  html: -> @render "html"

  render: (method) ->
    @el = Atoms.$ Atoms.render(@template)(@attributes)
    @molecule[method] @el
