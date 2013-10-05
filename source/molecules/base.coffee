###
Base class for Molecule

@namespace Atoms
@class BaseMolecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.BaseMolecule extends Atoms.Module

  @include Atoms.EventEmitter

  atoms   : {}
  bindings: null

  constructor: (@attributes) ->
    super
    @attributes.className = @className
    @type = "Molecule"
    @el = Atoms.$ Atoms.render(@template)(@attributes)
    @_readAttributes()
    @_assignParent()
    @_assignAtoms()

  _readAttributes: ->
     for attr of @attributes
      className = Atoms.className(attr)
      if Atoms.Atom?[className]
        @attributes[attr] = [@attributes[attr]] unless Atoms.isArray @attributes[attr]
        @atoms[attr] = []
        @atoms[attr].push atom for atom in @attributes[attr]

  _assignParent: ->
    if @attributes?.parent?
      @parent = Atoms.$ @attributes.parent
      @parent.append @el

  _assignAtoms: =>
    for index of @atoms
      className = Atoms.className(index)
      if Atoms.Atom?[className]
        atom = @atoms[index]
        atom = [atom] unless Atoms.isArray atom
        @[index] = []
        @[index].push @_atomInstance(className, child) for child in atom

  _atomInstance: (className, attributes) =>
    attributes.parent = @el
    atom = new Atoms.Atom?[className] attributes
    for event in @bindings[className.toLowerCase()]
      event_name = "#{className.toLowerCase()}#{Atoms.className(event)}"
      atom.bind "atom-#{event_name}", @[event_name]
    atom
