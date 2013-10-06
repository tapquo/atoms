###
Base class for Atom

@namespace Atoms
@class BaseAtom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @type = "Atom"
    if @attributes?.parent? and @template?
      @parent = Atoms.$ @attributes.parent
      if @attributes.method? then @render(@attributes.method) else @append()

    @bindEvents @events if @events?
    @el

  # Event handling
  bindEvents: (events) ->
    for evt in events
      event_name = Atoms.className(evt)
      @el.on evt, do (event_name) => (event) => @trigger event_name, event, @
