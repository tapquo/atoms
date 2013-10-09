###
Base class for Molecule

@namespace Atoms
@class BaseMolecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.List extends Atoms.Class.Molecule

  template: """
    <molecule-list>
      <li>1</li>
      <li>2</li>
    </molecule-list>
  """

  constructor: ->
    super
    @el.bind "click", (event) => @trigger "select", event
