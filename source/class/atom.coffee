###
Base class for Atom

@namespace Atoms.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

EVENTS_DESKTOP =
  touch             : "click"
  doubleTap         : "dblClick"

class Atoms.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.Scaffold
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  @type    = "Atom"
  @default = {}

  ###
  Render element with custom template and bind events (entity or user).
  @method constructor
  @param  attributes  OBJECT
  ###
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

  ###
  Binds to entity update trigger when instance has a entity.
  @method bindEntityUpdate
  @param  instance  ENTITY_INSTANCE
  ###
  bindEntityUpdate: (instance) =>
    if instance.uid is @entity.uid
      attributes = @entity.parse?() or @entity.attributes()
      @attributes[attribute] = attributes[attribute] for attribute of attributes
      do @refresh

  ###
  Binds to entity destroy trigger when instance has a entity.
  @method bindEntityDestroy
  @param  instance  ENTITY_INSTANCE
  ###
  bindEntityDestroy: (instance) =>
    do @destroy if instance.uid is @entity.uid

  ###
  Binds to user interface events.
  @method bindEvents
  ###
  bindEvents: ->
    if @attributes.events
      for event in @attributes.events
        event_desktop = EVENTS_DESKTOP[event] unless $$?
        @el.on event_desktop or event, do (event) => (handler) =>
          unless @el[0].disabled is true then @bubble event, handler
