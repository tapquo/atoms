"use strict"


class Atoms.BaseAtom extends Atoms.Module

  @include Atoms.EventEmitter

  molecule: null
  template: null

  constructor: (@attributes) ->
    @className = @constructor.name
    @type = "Atom"
    if @attributes?.molecule? and @template?
      @molecule = Atoms.$ @attributes.molecule
      if @attributes.method? then @render(@attributes.method) else @append()

    @bindEvents @events if @events?
    @el

  # Event handling
  bindEvents: (events) ->
    for evt in events
      @el.on evt, do (evt) => (event) => @trigger "atom-#{evt}", event

  # Output methods
  append: -> @render "append"

  prepend: -> @render "prepend"

  html: -> @render "html"

  render: (method) ->
    @el = Atoms.$ Atoms.render(@template)(@attributes)
    @molecule[method] @el
