###
Base class for Atom

@namespace Atoms.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.Event
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @constructor.type = "Atom"
    @output()

    if @attributes.events
      for evt in @attributes.events
        @el.on evt, do (evt) => (event) =>
          @trigger evt, event
          @bubble evt, event
