###
Base class for Organism

@namespace Atoms.Core.Class
@class Organism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Core.Class.Organism extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Output

  areas: []

  constructor: (@attributes) ->
    super
    @attributes.className = @className
    @type = "Organism"
    @render()
    for area in @areas
      if @attributes[area] then @_create area, @attributes[area]

  _create: (area, properties) ->
    el = @el.append("<#{area}></#{area}>").children(area)
    for type of properties
      for className of properties[type]
        if Atoms[Atoms.Core.Helper.className(type)][Atoms.Core.Helper.className(className)]?
          @[className] = [] unless @[className]?
          collection = properties[type][className]
          collection = [collection] unless Atoms.Core.Helper.isArray collection
          @_instance area, el, type, className, collection

  _instance: (area, parent, type, className, collection) ->
    for item in collection
      item.parent = parent
      instance = new Atoms[Atoms.Core.Helper.className(type)][Atoms.Core.Helper.className(className)] item
      @[className].push instance

      if @attributes.bindings?[area]?[className]?
        @bindList instance, className, @attributes.bindings[area][className], className
