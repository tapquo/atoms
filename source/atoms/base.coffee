"use strict"


class Atoms.BaseAtom extends Atoms.Module

  @include Atoms.EventEmitter

  template : null

  constructor: (@attributes) ->
    @className = @constructor.name
    @type = "Atom"
    if @attributes?.molecule? and @template?
      @molecule = Atoms.$ @attributes.molecule
      if @attributes.method? then @render(@attributes.method) else @append()

    @bindEvents @events if @events?

  # Event handling
  bindEvents: (events) ->
    for evt in events
      event_name = "atom-#{evt}"
      @bind event_name, @[evt]
      @el.on evt, do (evt, event_name) => (event) =>
        @trigger event_name, event

  # Output methods
  append: -> @render "append"

  prepend: -> @render "prepend"

  html: -> @render "html"

  render: (method) ->
    @el = Atoms.$ Atoms.render(@template)(@attributes)
    @molecule[method] @el
