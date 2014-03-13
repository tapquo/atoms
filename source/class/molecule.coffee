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
    if @attributes.bind?.entity? and @attributes.bind.atom? and @attributes.bind.auto
      do @_bindEntityEvents


  entity: (entities) ->
    do @_removeAtomsEntities
    if @attributes.bind?.entity? and @attributes.bind.atom? and Atoms.Atom[@attributes.bind.atom]?
      @_addAtomEntity entity for entity in entities

  # Entities
  _addAtomEntity: (entity) =>
    attributes = entity: entity
    for property in ["events", "callbacks"]
      attributes[property] = @attributes.bind[property] if @attributes.bind[property]?

    attributes = Atoms.Core.Helper.mix attributes, @default.children?[@attributes.entityAtom]
    @_entities.push @appendChild "Atom", @attributes.bind.atom, attributes

  _removeAtomsEntities: ->
    entity.el.remove() for entity in @_entities
    @_entities = []

  _bindEntityEvents : ->
    entity = Atoms.Entity[@attributes.bind.entity]
    new entity()
    entity.bind Atoms.Core.Constants.ENTITY.EVENT.CREATE, @_addAtomEntity
