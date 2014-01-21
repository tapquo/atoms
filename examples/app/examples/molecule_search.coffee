search = new Atoms.Molecule.Search()
  # atoms : [
  #   input: placeholder: "Your password..."
  # ,
  #   button: icon: "plus", text: null
  # ]

search.bind "enter", (args...) -> console.log "search", args
