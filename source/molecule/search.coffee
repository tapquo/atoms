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

  buttonClick: (event, atom) => @_search event, atom

  inputKeyup: (event, atom) =>
    @trigger "keyup", event.keyCode
    if event.keyCode is 13 then @_search event, atom

  _search: (event, atom) ->
    value = @input[0].el.val()
    @trigger "enter", value if value isnt ""


