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

  ###
  Render element with custom template and instance all Atom children.
  @method constructor
  @param  attributes OBJECT
  ###
  constructor: (@attributes) ->
    super
    @children = []
    @cache    = []

    do @scaffold
    do @output
    do @chemistry
    do @_bindEntity if @attributes.bind?.entity? and @attributes.bind.atom?

  ###
  Creates new Atom children with a determinate group of entities.
  @method entity
  @param  entities  ARRAY
  @param  append    BOOLEAN (default = False)
  ###
  entity: (entities, append = false) ->
    do @destroyChildren unless append
    if @attributes.bind?.entity? and @attributes.bind.atom?
      @_addAtomEntity entity, @attributes.bind for entity in entities

  _addAtomEntity: (entity, bind, save = true) =>
    attributes =
      entity: entity
      bind  :
        create : bind.create
        update : bind.update
        destroy: bind.destroy

    for property in ["events", "callbacks"] when @attributes.bind[property]?
      attributes[property] = @attributes.bind[property]

    attributes = Atoms.Core.Helper.mix attributes, @default.children?[@attributes.entityAtom]
    atom = @appendChild "#{@attributes.bind.atom}", attributes
    @cache.push atom if save
    atom

  _bindEntity : =>
    entity = @attributes.bind.entity.toClassObject()
    if entity?
      entity.observe (state) =>
        if state.type is "add" and @attributes.bind.create
          @_addAtomEntity state.object, @attributes.bind
        else if state.type in ["delete", "destroy"]
          for record, index in @cache when record.entity.uid is state.oldValue.uid
            @cache.splice index, 1
            break
