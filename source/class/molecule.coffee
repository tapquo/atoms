###
Base class for Molecule

@namespace Atoms
@class BaseMolecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Molecule extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Chemistry
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @attributes.className = @className
    @type = "Molecule"
    @render()
    @chemistry()
