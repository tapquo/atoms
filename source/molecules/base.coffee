"use strict"

class Atoms.BaseMolecule extends Atoms.Module

  @include Atoms.EventEmitter

  organism: null
  atoms   : {}

  constructor: (@attributes) ->
    @className = @constructor.name
    @type = "Molecule"
    if @attributes?.organism?
      @organism = Atoms.$ @attributes.organism

    @createAtoms()

  createAtoms: =>
    console.log ">", @atoms
    for index of @atoms
      atom = @atoms[index]
      className = index[0].toUpperCase() + index[1..-1].toLowerCase()

      attributes = @attributes[index] or atom
      attributes.molecule = @organism

      @[index] = new Atoms.Atom[className] attributes
      @[index].bind "atom-#{event}", @[event] for event in atom.binds
