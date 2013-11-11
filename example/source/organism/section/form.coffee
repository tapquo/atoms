class Form extends Atoms.Organism.Section

  @scaffold "source/organism/section/form.yml"


  formKeyup: (event) -> console.log "ku", event

  formKeypress: (event) -> console.log "kp", event

  formClick: (event, atom, molecule) -> console.log "value: ", molecule.value()

  buttonClick: (event) ->
    console.log "Atom.Button clicked"
    Atoms.System.Cache.Loading.show()
    setTimeout ->
      Atoms.System.Cache.Loading.hide()
    , 850

form = new Form parent: "article#first"
