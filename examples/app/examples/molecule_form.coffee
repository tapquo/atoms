form = new Atoms.Molecule.Form
  parent: "article section"
  atoms : [
    label: text: "prueba"
  ,
    input: type: "text", name: "name", placeholder: "Your name...", style: "big"
  ,
    input: type: "password", name: "password", placeholder: "Your password..."
  ,
    label: text: "prueba"
  ,
    button: icon: "plus", text: "Save", style: "fluid accept"
  ,
    button: icon: "profile", text: "prieba", style: "fluid cancel", disabled: true
  ]
  # events:
  #   input: ["keyup"]
  triggers: ["keypress", "keyup", "touch"]

form.bind "keyup", (event) ->
  console.log "keyupped", event

form.bind "touch", (event) ->
  console.log "touched", event
