$ ->
  class First extends Atoms.Organism.Article

    @scaffold "organisms/first.yml"

    navigationSelect: (event, atom, molecule) ->
      console.log "event", event
      console.log "atom", atom
      console.log "molecule", molecule

    formKeyup: (keycode, atom, molecule) ->
      console.log keycode, atom, molecule

    formClick: (event, atom) ->
      console.log event, atom

  first = new First parent: document.body, id: "first"


  class Second extends Atoms.Organism.Article

    @scaffold "organisms/second.yml"

  second = new Second parent: document.body, id: "second"


  Atoms.System.Layout.show "Second"
