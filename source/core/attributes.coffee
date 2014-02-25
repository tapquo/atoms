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

  chemistry: (children) ->
    children = @attributes.children or @default.children or []
    for item, index in children
      for key of item
        base = key.split(".")
        type = base[0]
        class_name = base[1]
        if Atoms[type][class_name]?
          attributes = item[key]
          if @default?.children?[index]?[key]?
            attributes = Atoms.Core.Helper.mix item[key], @default.children?[index]?[key]
          @appendChild type, class_name, attributes

  appendChild: (type, class_name, attributes={}) ->
    if @__available type, class_name
      attributes.parent = attributes.parent or @
      child = new Atoms[type][class_name] attributes
      @children.push child
      @[attributes.id] = child if attributes.id
      child
    else
      console.error "Instance #{type}.#{class_name} no available in #{constructor.name} (#{constructor.base})"

  __available: (type, class_name) ->
    instance = Atoms[type][class_name]
    instance = instance.base or instance.name
    (not @constructor.available or "#{type}.#{instance}" in @constructor.available)
