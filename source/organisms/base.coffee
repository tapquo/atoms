###
Base class for Organism

@namespace Atoms
@class BaseOrganism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.BaseOrganism extends Atoms.Module

  @include Atoms.EventEmitter

  molecules : {}
  bindings: null

  constructor: (@attributes) ->
    super
    @attributes.className = @className
    @type = "Organism"
    @el = Atoms.$ Atoms.render(@template)(@attributes)

    if @attributes?.parent?
      @parent = Atoms.$ @attributes.parent
      @parent.append @el

    @_assignMolecules()
    @

  _assignMolecules: =>
    for index of @molecules
      className = Atoms.className(index)
      if Atoms.Molecule[className]?
        molecule = @molecules[index]
        attributes = @attributes.molecule?[index] or molecule
        @[index] = @_moleculeInstance className, attributes

  _moleculeInstance: (className, attributes) =>
    attributes.parent = @el
    molecule = new Atoms.Molecule?[className] attributes
    if @bindings[className.toLowerCase()]?
      className = className.toLowerCase()
      for event in @bindings[className]
        molecule.bind event, @["#{className}#{Atoms.className(event)}"]
    molecule
