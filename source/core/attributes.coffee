###
HTML Renderer

@namespace Atoms.Core
@class Attributes

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Attributes =

  ###
  Set the parent instance to current instance.
  @method setParent
  ###
  scaffold: ->
    # Assign Parrent
    @parent = {}
    if @attributes?.parent?
      @parent = @attributes.parent
      delete @attributes.parent

    # Assign Container
    @container = @attributes.container or @parent.el or document.body
    delete @attributes.container

    # Assign Entity
    if @attributes?.entity?
      @entity = @attributes.entity
      delete @attributes.entity

  chemistry: ->
    for item in @attributes.children or @constructor.default?.children or []
      @appendChild class_name, item[class_name] for class_name of item

  appendChild: (class_name, attributes={}) ->
    child_constructor = __getConstructor class_name
    if child_constructor
      if @__available child_constructor

        if child_constructor.default?
          attributes = Atoms.Core.Helper.mix attributes, child_constructor.default

        attributes.parent = attributes.parent or @
        child = new child_constructor attributes
        @children.push child
        @[attributes.id] = child if attributes.id
        child
      else
        console.error "Instance #{class_name} not available in #{@constructor.type}.#{@constructor.base} ##{@constructor.name}."
    else
      console.error "Instance #{class_name} doesn't exists."

  destroyChildren: ->
    child.destroy?() for child in @children or []
    @children = []

  __available: (instance) ->
    base = "#{instance.type}." + (instance.base or instance.name)
    (not @constructor.available or base in @constructor.available)


__getConstructor = (class_name) ->
  instance = Atoms
  instance = instance[item] for item in class_name.split(".") when instance?
  instance
