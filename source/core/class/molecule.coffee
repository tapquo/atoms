###
Base class for Molecule

@namespace Atoms.Core.Class
@class Molecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Core.Class.Molecule extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @constructor.type = "Molecule"
    @render()
    @atoms = {} unless @atoms?
    @chemistry()


  chemistry: (elements) ->
    # Read Attributes
    for attr of @attributes
      className = Atoms.Core.Helper.className(attr)
      if Atoms.Atom[className]? and @atoms[attr]?
        @attributes[attr] = [@attributes[attr]] unless Atoms.Core.Helper.isArray @attributes[attr]
        base = @atoms[attr]
        @atoms[attr] = (Atoms.Core.Helper.mix(item, base) for item in @attributes[attr])

    # Normalize values
    for index of @atoms
      @[index] = null
      className = Atoms.Core.Helper.className(index)
      if Atoms.Atom[className]?
        item = @atoms[index]
        item = [item] unless Atoms.Core.Helper.isArray item
        @[index] = (@_atomInstance(className, child) for child in item)


  _atomInstance: (className, attributes) ->
    attributes.parent = @el
    attributes.events = @bindings?[className.toLowerCase()] or []

    instance = new Atoms.Atom[className] attributes
    if attributes.events.length > 0 then @bindList instance, className, attributes.events
    instance
