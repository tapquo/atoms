###
Base class for Atom

@namespace Atoms.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.Attributes
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @default = events: [] unless @default
    @attributes = Atoms.Core.Helper.mix @attributes, @default
    @constructor.type = "Atom"

    do @scaffold
    if @entity
      attributes = @entity.parse?() or @entity.attributes()
      @attributes = Atoms.Core.Helper.mix @attributes, attributes
      EVENT = Atoms.Core.Constants.ENTITY.EVENT
      Atoms.Entity[@entity.className].bind EVENT.UPDATE, @bindUpdate
      Atoms.Entity[@entity.className].bind EVENT.DESTROY, @bindDestroy
    do @output
    @bindEvents()

  bindUpdate: (model) =>
    if model.uid is @entity.uid
      attributes = @entity.parse?() or @entity.attributes()
      @attributes[attribute] = @entity[attribute] for attribute of attributes
      do @refresh

  bindDestroy: (model) =>
    if model.uid is @entity.uid
      do @destroy

  bindEvents: ->
    if @attributes.events
      for evt in @attributes.events
        @el.on evt, do (evt) => (event) => @bubble evt, event
