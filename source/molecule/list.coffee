###
Base class for Molecule

@namespace Atoms
@class BaseMolecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.List extends Atoms.Class.Molecule

  template: """
    <ul></ul>
  """

  bindings:
    li: ["click"]

  liClick: (event, atom) =>
    @trigger "click", atom
