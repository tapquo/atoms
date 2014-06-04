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

  constructor: (@attributes) ->
    super
    @default = children: [] unless @default
    @children = []
    @_records = []

    do @scaffold
    do @output
    do @chemistry
    if @attributes.bind?.entity? and @attributes.bind.atom? and @attributes.bind.create
      do @_bindEntityCreate

  entity: (entities, append = false) ->
    do @_removeAtomsEntities unless append
    if @attributes.bind?.entity? and @attributes.bind.atom?
      @_addAtomEntity entity, @attributes.bind for entity in entities

  # Entities
  _addAtomEntity: (entity, bind, record = true) =>
    attributes =
      entity: entity
      bind  :
        update : bind.update
        destroy: bind.destroy

    for property in ["events", "callbacks"] when @attributes.bind[property]?
      attributes[property] = @attributes.bind[property]

    attributes = Atoms.Core.Helper.mix attributes, @default.children?[@attributes.entityAtom]
    atom = @appendChild "#{@attributes.bind.atom}", attributes
    @_records.push atom if record
    atom

  _removeAtomsEntities: =>
    record.el.remove() for record in @_records
    @_records = []

  _bindEntityCreate : ->
    entity = @attributes.bind.entity.toClassObject()
    if entity?
      new entity()
      entity.bind Atoms.Core.Constants.ENTITY.EVENT.CREATE, (entity) =>
        @_addAtomEntity entity, @attributes.bind
