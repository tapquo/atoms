###
Basic fieldset for search

@namespace Atoms.Molecule
@class Search

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Search extends Atoms.Class.Molecule

  template: """
    <fieldset molecule-class="{{className}}"></fieldset>
  """

  atoms:
    label:
      text: "Search:"
    input:
      placeholder : "Type your search..."
    button:
      label       : "Go!"

  bindings:
    input: ["keyup"]
    button: ["click"]

  buttonClick: (event, atom) => @_trigger()

  inputKeyup: (event, atom) => @_trigger() if event.keyCode is 13

  _trigger: ->
    value = @input[0].el.val()
    if value isnt ""
      @trigger "on", value
    else
      @trigger "off"

