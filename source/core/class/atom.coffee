###
Base class for Atom

@namespace Atoms.Core.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Core.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @type = "Atom"
    @render()

    if @events?
      for evt in @events
        event_name = Atoms.Core.Helper.className(evt)
        @el.on evt, do (event_name) => (event) => @trigger event_name, event, @
    @
