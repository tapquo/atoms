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
    @attributes.className = @className
    @type = "Molecule"
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
        @[index] = (@_instance(className, child) for child in item)


  _instance: (className, attributes) ->
    attributes.parent = @el
    instance = new Atoms.Atom[className] attributes
    if @bindings?[className.toLowerCase()]?
      @bindList instance, className, @bindings[className.toLowerCase()]
    instance
