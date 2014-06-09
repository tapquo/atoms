###
Children Chemistry

@namespace Atoms.Core
@class Attributes

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Children =

  default: children: []

  ###
  Set the parent instance to current instance.
  @method chemistry
  ###
  chemistry: ->
    for item in @attributes.children or @constructor.default?.children or []
      @appendChild class_name, item[class_name] for class_name of item

  ###
  Set the parent instance to current instance.
  @method appendChild
  ###
  appendChild: (class_name, attributes={}) ->
    child_constructor = class_name.toClassObject(Atoms)
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

  ###
  Set the parent instance to current instance.
  @method destroyChildren
  ###
  destroyChildren: ->
    child.destroy?() for child in @children or []
    @children = []

  __available: (instance) ->
    base = "#{instance.type}." + (instance.base or instance.name)
    (not @constructor.available or base in @constructor.available)
