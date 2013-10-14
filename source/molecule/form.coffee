###
Basic fieldset for search

@namespace Atoms.Molecule
@class Form

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Form extends Atoms.Core.Class.Molecule

  template: """
    <form molecule-form molecule-class="{{className}}"></form>
  """

  bindings:
    input: ["keyup", "keypress"]
    button: ["click"]

  constructor: ->
    @atoms = input: [], button: []
    super

  inputKeypress: (event, atom) =>
    @trigger "keypress", event.keyCode, atom

  inputKeyup: (event, atom) =>
    @trigger "keyup", event.keyCode, atom

  buttonClick: (event, atom) =>
    event.preventDefault()
    @trigger "click", event, atom
