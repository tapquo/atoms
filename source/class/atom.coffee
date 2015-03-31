###
Base class for Atom

@namespace Atoms.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

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
    do @scaffold
    if @entity
      attributes = @entity.parse?() or @entity.fields()
      @attributes = Atoms.Core.Helper.mix @attributes, attributes
      @entity.observe (state) =>
        do @bindEntityDestroy if @attributes.bind.destroy and state.type is "destroy"
        do @bindEntityUpdate if @attributes.bind.update and state.type is "update"

    do @output
    do @bindEvents

  ###
  Binds to entity update trigger when instance has a entity.
  @method bindEntityUpdate
  @param  instance  ENTITY_INSTANCE
  ###
  bindEntityUpdate: =>
    attributes = @entity.parse?() or @entity.fields()
    @attributes[attribute] = attributes[attribute] for attribute of attributes
    do @refresh

  ###
  Binds to entity destroy trigger when instance has a entity.
  @method bindEntityDestroy
  @param  instance  ENTITY_INSTANCE
  ###
  bindEntityDestroy: (instance) =>
    do @destroy

  ###
  Binds to user interface events.
  @method bindEvents
  ###
  bindEvents: ->
    do @handleInputEvent if @attributes.events
