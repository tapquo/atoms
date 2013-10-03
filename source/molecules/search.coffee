"use strict"

class Atoms.Molecule.Search extends Atoms.BaseMolecule

  template: """
    <molecule-search atom-class="{{className}}">
      <label>{{label}}</label>
      {{atom}}
    </molecule-search>
  """

  atoms:
    input:
      placeholder : "Type your password..."
      binds       : ["keyup"]
    button:
      label       : "Click to search"
      binds       : ["click"]

  click: =>
    @_trigger @input.el.val()

  keyup: (event) =>
    @_trigger @input.el.val() if event.keyCode is 13

  # Triggers
  _trigger: (value) ->
    if value isnt ""
      @trigger "molecule-search_on", value
    else
      @trigger "molecule-search_off"

