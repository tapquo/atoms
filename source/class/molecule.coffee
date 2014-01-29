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
    @childrenClass = []
    @default = children: [] unless @default
    @constructor.type = "Molecule"
    do @scaffold
    do @output
    do @chemistry

  chemistry: (elements) ->
    children = @attributes.children or @default.children
    for atom, index in children
      for key of atom when key in @available
        className = key.toClassName()
        if Atoms.Atom[className]?
          attributes = Atoms.Core.Helper.mix atom[key], @default.children?[index]?[key]
          instance = @_atomInstance key, className, attributes
          @childrenClass.push instance
          @[key] = [] unless @[key]?
          @[key].push instance

  entityAtom: (@atomEntity) -> @

  entity: (entities) ->
    do @_removeAtomsEntities

    for entity in entities when Atoms.Atom[@atomEntity]?
      attributes = entity: entity
      attributes = Atoms.Core.Helper.mix attributes, @default.children?[@atomEntity]
      @_entities.push @_atomInstance null, @atomEntity, attributes

  # Private Methods
  _atomInstance: (key, className, attributes) ->
    attributes.parent = @
    attributes.events = attributes.events or @attributes.events?[key] or @default.events?[key] or []

    instance = new Atoms.Atom[className] attributes
    if attributes.events.length > 0 then @bindList instance, attributes.events
    instance

  _removeAtomsEntities: ->
    entity.el.remove() for entity in @_entities
    @_entities = []
