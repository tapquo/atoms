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

  entityAtom: (@atomEntity) -> @

  entity: (entities) ->
    do @_removeAtomsEntities
    for entity in entities when Atoms.Atom[@atomEntity]?
      attributes = entity: entity
      attributes = Atoms.Core.Helper.mix attributes, @default.children?[@atomEntity]
      @_entities.push @appendChild "Atom", @atomEntity, attributes

  _removeAtomsEntities: ->
    entity.el.remove() for entity in @_entities
    @_entities = []
