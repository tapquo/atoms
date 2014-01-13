class Atoms.App.Section.Main extends Atoms.Organism.Section

  @scaffold "source/second/main.yml"

  buttonTouch: ->
    modal = new Atoms.Molecule.Confirm
      icon    : "search"
      title   : "Find your friends"
      text    : "lorem ipsum"
      accept  : "Yes"
      cancel  : "No"
    modal.show()
    modal.bind "accept", (event) ->
      console.log "accept"
      Atoms.App.Modal.Loading.show()
    modal.bind "cancel", (event) -> console.log "cancel"
