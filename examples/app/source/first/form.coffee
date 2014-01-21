class Atoms.App.Section.Form extends Atoms.Organism.Section

  @scaffold "source/first/form.yml"

  formKeyup: (event) ->
    console.log "ku", event

  formKeypress: (event) ->
    console.log "kp", event

  formSubmit: (event, args...) ->
    form = args[1]
    console.log "value: ", form.value()

  bubbleFormSubmit: (event, form, hierarchy...) ->
    console.info "<section> bubbleFormSubmit", form.value()
    # @tunnel "va", data: "mi data"

  _modalShow: () ->
    Atoms.App.Modal.Loading.show()
    setTimeout ->
      Atoms.App.Modal.Loading.hide()
    , 850

