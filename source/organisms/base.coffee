###
Base class for Organism

@namespace Atoms
@class BaseOrganism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.BaseOrganism extends Atoms.Module

  @include Atoms.EventEmitter

  system    : null
  molecules : {}
  template  : ""

  constructor: (@attributes) ->
    super
    @type = "Organism"

    @el = Atoms.$ Atoms.render(@template)(@attributes)
    if @attributes?.system?
      @system = Atoms.$ @attributes.system
      @system.append @el

    @createMolecules()
    @


  createMolecules: ->
    for index of @molecules
      molecule = @molecules[index]
      className = index[0].toUpperCase() + index[1..-1].toLowerCase()

      attributes = @attributes.molecule?[index] or molecule
      attributes.organism = @el

      @[index] = new Atoms.Molecule[className] attributes
      @[index].bind "molecule-#{event}", @[event] for event in molecule.binds
