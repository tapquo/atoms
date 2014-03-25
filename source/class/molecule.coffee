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

  @type = "Molecule"

  _records: []

  constructor: (@attributes) ->
    super
    @default = children: [] unless @default
    @children = []
    do @scaffold
    do @output
    do @chemistry
    if @attributes.bind?.entity? and @attributes.bind.atom? and @attributes.bind.auto
      do @_bindEntityEvents

  entity: (entities) ->
    do @_removeAtomsEntities
    if @attributes.bind?.entity? and @attributes.bind.atom?
      @_addAtomEntity entity for entity in entities

  # Entities
  _addAtomEntity: (entity, record = true) =>
    attributes = entity: entity
    for property in ["events", "callbacks"] when @attributes.bind[property]?
      attributes[property] = @attributes.bind[property]

    attributes = Atoms.Core.Helper.mix attributes, @default.children?[@attributes.entityAtom]
    atom = @appendChild "#{@attributes.bind.atom}", attributes
    @_records.push atom if record
    atom

  _removeAtomsEntities: ->
    entity.el.remove() for entity in @_records
    @_records = []

  _bindEntityEvents : ->
    entity = Atoms.Entity[@attributes.bind.entity]
    if entity?
      new entity()
      entity.bind Atoms.Core.Constants.ENTITY.EVENT.CREATE, @_addAtomEntity
