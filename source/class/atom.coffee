###
Base class for Atom

@namespace Atoms.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

EVENTS_DESKTOP =
  touch             : "click"
  singleTap         : "click"
  tap               : "click"
  doubleTap         : "dblClick"

class Atoms.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.Scaffold
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  @type    = "Atom"
  @default = {}

  constructor: (@attributes) ->
    super
    @attributes = Atoms.Core.Helper.mix @attributes, @constructor.default

    do @scaffold
    if @entity
      attributes = @entity.parse?() or @entity.attributes()
      @attributes = Atoms.Core.Helper.mix @attributes, attributes

      entity = @entity.className.toClassObject(__.Entity)
      if entity
        EVENT = Atoms.Core.Constants.ENTITY.EVENT
        entity.bind EVENT.UPDATE, @bindEntityUpdate if @attributes.bind.update
        entity.bind EVENT.DESTROY, @bindEntityDestroy if @attributes.bind.destroy
    do @output
    @bindEvents()

  bindEntityUpdate: (model) =>
    if model.uid is @entity.uid
      attributes = @entity.parse?() or @entity.attributes()
      @attributes[attribute] = attributes[attribute] for attribute of attributes
      do @refresh

  bindEntityDestroy: (model) =>
    do @destroy if model.uid is @entity.uid

  bindEvents: ->
    if @attributes.events
      for event in @attributes.events
        event_desktop = EVENTS_DESKTOP[event] unless $$?
        @el.on event_desktop or event, do (event) => (handler) =>
          unless @el[0].disabled is true then @bubble event, handler
