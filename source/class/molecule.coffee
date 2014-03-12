###
Base class for Molecule

@namespace Atoms.Class
@class Molecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Molecule extends Atoms.Core.Module

  @include Atoms.Core.Attributes
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  _entities: []

  constructor: (@attributes) ->
    super
    @default = children: [] unless @default
    @children = []
    @constructor.type = "Molecule"
    do @scaffold
    do @output
    do @chemistry
    if @attributes.entityBind? and @attributes.entityAtom?
      Atoms.$ => do @_bindEntityEvents

  entity: (entities) ->
    do @_removeAtomsEntities
    if @attributes.entityAtom? and Atoms.Atom[@attributes.entityAtom]?
      @_addAtomEntity entity for entity in entities

  # Entities
  _addAtomEntity: (entity) ->
    attributes = Atoms.Core.Helper.mix entity: entity, @default.children?[@attributes.entityAtom]
    @_entities.push @appendChild "Atom", @attributes.entityAtom, attributes

  _removeAtomsEntities: ->
    entity.el.remove() for entity in @_entities
    @_entities = []

  _bindEntityEvents : =>
    EVENT = Atoms.Core.Constants.ENTITY.EVENT
    Atoms.Entity[@attributes.entityBind].bind EVENT.CREATE, @_bindEntityCreate

  _bindEntityCreate: (entity) =>
    @_addAtomEntity entity
