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
    @output()
    @chemistry()

  chemistry: (elements) ->
    children = @attributes.children or @default.children
    for atom, index in children
      for key of atom when @available.indexOf(key) > -1
        className = Atoms.Core.Helper.className(key)
        if Atoms.Atom[className]?
          attributes = Atoms.Core.Helper.mix atom[key], @default.children?[index]?[key]

          @[key] = [] unless @[key]?
          @[key].push @_atomInstance key, className, attributes


  _atomInstance: (key, className, attributes) ->
    attributes.parent = @el
    attributes.events = attributes.events or @attributes.events?[key] or @default.events?[key] or []

    instance = new Atoms.Atom[className] attributes
    instance.parentClass = @
    if attributes.events.length > 0 then @bindList instance, attributes.events
    instance
