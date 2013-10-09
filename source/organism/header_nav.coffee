
class Atoms.Organism.HeaderNavigation extends Atoms.Class.Organism

  template: """
    <header organism-class="{{class}}">
      <span class="title">{{title}}</span>
    </header>"""

  bindings:
    navigation: ["select"]

  method: "prepend"

  constructor: (@attributes) ->
    @molecules = navigation: []
    @attributes.method = "prepend"
    super

  navigationSelect: (atom, navigation) ->
    console.log atom.attributes.text, atom, navigation
