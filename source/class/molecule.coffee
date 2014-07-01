###
Base class for Molecule

@namespace Atoms.Class
@class Molecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Molecule extends Atoms.Core.Module

  @include Atoms.Core.Scaffold
  @include Atoms.Core.Children
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  @type = "Molecule"

  constructor: (@attributes) ->
    super
    @children = []
    @_records = []

    do @scaffold
    do @output
    do @chemistry
    if @attributes.bind?.entity? and @attributes.bind.atom? and @attributes.bind.create
      do @_bindEntity

  entity: (entities, append = false) ->
    do @destroyChildren unless append
    if @attributes.bind?.entity? and @attributes.bind.atom?
      @_addAtomEntity entity, @attributes.bind for entity in entities

  destroyChildren: ->
    child.destroy?() for child in @children or []
    @children = []
    @_records = []

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

  _bindEntity : ->
    entity = @attributes.bind.entity.toClassObject()
    if entity?
      new entity()
      entity.bind Atoms.Core.Constants.ENTITY.EVENT.CREATE, (entity) =>
        @_addAtomEntity entity, @attributes.bind

      entity.bind Atoms.Core.Constants.ENTITY.EVENT.DESTROY, (entity) =>
        for record, index in @_records when record.entity.uid is entity.uid
          @_records.splice index, 1
          break
