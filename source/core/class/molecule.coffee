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
    @chemistry()


  chemistry: (elements) ->
    atoms = @attributes.atoms or @default.atoms
    for atom, index in atoms
      for key of atom when @available.indexOf(key) > -1
        className = Atoms.Core.Helper.className(key)
        if Atoms.Atom[className]?
          attributes = Atoms.Core.Helper.mix atom[key], @default.atoms?[index]?[key]

          @[key] = [] unless @[key]?
          @[key].push @_atomInstance key, className, attributes


  _atomInstance: (key, className, attributes) ->
    attributes.parent = @el
    attributes.events = attributes.events or @attributes.events?[key] or @default.events?[key] or []

    instance = new Atoms.Atom[className] attributes
    if attributes.events.length > 0 then @bindList instance, attributes.events
    instance
