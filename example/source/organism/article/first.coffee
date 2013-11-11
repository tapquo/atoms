class First extends Atoms.Organism.Article

    @scaffold "source/organism/article/first.yml"

    navigationSelect: (event, atom, molecule) ->
      console.log "event", event
      console.log "atom", atom
      console.log "molecule", molecule




first = new First parent: document.body
