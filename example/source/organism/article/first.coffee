class First extends Atoms.Organism.Article

    @scaffold "source/organism/article/first.yml"

    navigationSelect: (event, atom, molecule) ->
      console.log "event", event
      console.log "atom", atom
      console.log "molecule", molecule

    formKeyup: (event) -> console.log "ku", event

    formKeypress: (event) -> console.log "kp", event

    formClick: (event, atom, molecule) -> console.log "value: ", molecule.value()

    buttonClick: (event) ->
      console.log "Atom.Button clicked"
      Atoms.System.Cache.Loading.show()
      setTimeout ->
        Atoms.System.Cache.Loading.hide()
      , 850


  # first = new First parent: document.body
