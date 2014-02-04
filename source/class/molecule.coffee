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

  chemistry: (elements) ->
    children = @attributes.children or @default.children
    for atom, index in children
      for key of atom when key in @available
        item = key.split(".")
        type = item[0]
        class_name = item[1]
        if Atoms[type][class_name]?
          attributes = Atoms.Core.Helper.mix atom[key], @default.children?[index]?[key]
          instance = @_atomInstance class_name, attributes
          @children.push instance
          @[key] = [] unless @[key]?
          @[key].push instance

  entityAtom: (@atomEntity) -> @

  entity: (entities) ->
    do @_removeAtomsEntities
    for entity in entities when Atoms.Atom[@atomEntity]?
      attributes = entity: entity
      attributes = Atoms.Core.Helper.mix attributes, @default.children?[@atomEntity]
      @_entities.push @_atomInstance @atomEntity, attributes

  # Private Methods
  _atomInstance: (class_name, attributes) ->
    attributes.parent = @
    new Atoms.Atom[class_name] attributes

  _removeAtomsEntities: ->
    entity.el.remove() for entity in @_entities
    @_entities = []
