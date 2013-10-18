###
Basic fieldset for search

@namespace Atoms.Molecule
@class Search

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Search extends Atoms.Core.Class.Molecule

  @template """
    <fieldset></fieldset>
  """

  bindings:
    input: ["keyup"]
    button: ["click"]

  constructor: ->
    @atoms =
      input:
        type: "search"
        placeholder : "Type your search..."
      button:
        text       : "Go!"
    super

  buttonClick: (event, atom) =>
    @_search event, atom

  inputKeyup: (event, atom) =>
    @trigger "keyup", event.keyCode
    if event.keyCode is 13 then @_search event, atom

  _search: (event, atom) ->
    value = @input[0].el.val()
    @trigger "enter", value, atom if value isnt ""
