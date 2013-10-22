$ ->

  class First extends Atoms.Organism.Article

    @scaffold "organisms/first.yml"

    navigationSelect: (event, atom, molecule) ->
      console.log "event", event
      console.log "atom", atom
      console.log "molecule", molecule

    formKeyup: (event) -> console.log "ku", event

    formKeypress: (event) -> console.log "kp", event

    formClick: (event, atom, molecule) ->
      console.log "Attributes: ", molecule.value()

    buttonClick: (event) -> console.log "Atom.Button clicked"

  first = new First parent: document.body

  Atoms.System.Layout.show "First"
