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
    @constructor.type = "Atom"
    @render()

    if @attributes.events
      for evt in @attributes.events
        @el.on evt, do (evt) => (event) => @trigger evt, event, @
