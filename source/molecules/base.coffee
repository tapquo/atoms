"use strict"

class Atoms.BaseMolecule extends Atoms.Module

  @include Atoms.EventEmitter

  organism: null
  atoms   : {}

  constructor: (@attributes) ->
    super
    @type = "Molecule"
    @el = Atoms.$ Atoms.render(@template)(@attributes)
    if @attributes?.organism?
      @organism = Atoms.$ @attributes.organism
      @organism.append @el
    @createAtoms()

  createAtoms: =>
    for index of @atoms
      atom = @atoms[index]
      className = index[0].toUpperCase() + index[1..-1].toLowerCase()

      attributes = @attributes[index] or atom
      attributes.molecule = @el

      @[index] = new Atoms.Atom?[className] attributes
      @[index].bind "atom-#{event}", @[event] for event in atom.binds
