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

  @events = (@evts...) -> @

  constructor: (@attributes) ->
    super
    @constructor.type = "Atom"
    @render()

    if @constructor.evts?
      for evt in @constructor.evts
        event_name = Atoms.Core.Helper.className(evt)
        @el.on evt, do (event_name) => (event) => @trigger event_name, event, @

