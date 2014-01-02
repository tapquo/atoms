class Atoms.App.Section.Form extends Atoms.Organism.Section

  @scaffold "source/first/form.yml"

  formKeyup: (event) ->
    console.log "ku", event

  formKeypress: (event) ->
    console.log "kp", event

  formSubmit: (event, atom, molecule) ->
    console.log "value: ", molecule.value()

  buttonTouch: (event) ->
    Atoms.App.Modal.Loading.show()
    setTimeout ->
      Atoms.App.Modal.Loading.hide()
    , 850


