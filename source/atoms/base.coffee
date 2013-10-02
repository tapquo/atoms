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

  append: -> @render "append"

  prepend: -> @render "prepend"

  html: -> @render "html"

  render: (method) -> @molecule[method] Atoms.render(@template)(@attributes)
