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

  @type    = "Atom"
  @default = {}

  constructor: (@attributes) ->
    super
    @attributes = Atoms.Core.Helper.mix @attributes, @constructor.default

    do @scaffold
    if @entity
      attributes = @entity.parse?() or @entity.attributes()
      @attributes = Atoms.Core.Helper.mix @attributes, attributes
      EVENT = Atoms.Core.Constants.ENTITY.EVENT
      Atoms.Entity[@entity.className].bind EVENT.UPDATE, @bindEntityUpdate
      Atoms.Entity[@entity.className].bind EVENT.DESTROY, @bindEntityDestroy
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
      for evt in @attributes.events
        @el.on evt, do (evt) => (event) => @bubble evt, event
