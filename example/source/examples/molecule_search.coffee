search = new Atoms.Molecule.Search
  parent: document.body
  # atoms : [
  #   input: placeholder: "Your password..."
  # ,
  #   button: icon: "plus", text: null
  # ]

search.bind "enter", (args...) -> console.log "search", args
