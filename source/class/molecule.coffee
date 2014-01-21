###
Base class for Molecule

@namespace Atoms.Class
@class Molecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Molecule extends Atoms.Core.Module

  @include Atoms.Core.Event
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @childrenClass = []
    @default = children: [] unless @default
    @constructor.type = "Molecule"
    do @instance
    do @output
    do @chemistry

  chemistry: (elements) ->
    children = @attributes.children or @default.children
    for atom, index in children
      for key of atom when @available.indexOf(key) > -1
        className = key.toClassName()
        if Atoms.Atom[className]?
          attributes = Atoms.Core.Helper.mix atom[key], @default.children?[index]?[key]
          instance = @_atomInstance key, className, attributes
          @childrenClass.push instance
          @[key] = [] unless @[key]?
          @[key].push instance


  _atomInstance: (key, className, attributes) ->
    attributes.parent = @
    attributes.events = attributes.events or @attributes.events?[key] or @default.events?[key] or []

    instance = new Atoms.Atom[className] attributes
    if attributes.events.length > 0 then @bindList instance, attributes.events
    instance
