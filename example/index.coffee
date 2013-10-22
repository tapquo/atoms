$ ->
  console.log "------------------------------------------------------------"
  console.log "Atoms v#{Atoms.version}", Atoms
  console.log "------------------------------------------------------------"

  # search = new Atoms.Molecule.Search
  #   parent: "article section"
  #   atoms : [
  #     input: placeholder: "Your password..."
  #   ,
  #     button: icon: "plus", text: null
  #   ]
  # search.bind "enter", (args...) -> console.log "search", args

  # form = new Atoms.Molecule.Form
  #   parent: "article section"
  #   style : "clase"
  #   atoms : [
  #     label: text: "prueba"
  #   ,
  #     input: type: "text", name: "name", placeholder: "Your name..."
  #   ,
  #     input: type: "password", name: "password", placeholder: "Your password..."
  #   ,
  #     label: text: "prueba"
  #   ,
  #     button: icon: "plus", text: "Save", style: "fluid accept"
  #   ]
  #   # events:
  #   #   input: ["keyup"]
  #   triggers: ["keypress", "keyup", "click"]

  # form.bind "keyup", (event) -> console.log "keyupped", event

  # form.bind "click", (event) ->
  #   console.log "clicked", event


  # nav = new Atoms.Molecule.Navigation
  #   parent: "article section"
  #   atoms : [
  #     button: icon: "plus", text: "Save"
  #   ,
  #     button: icon: "plus", text: "Save"
  #   ]

