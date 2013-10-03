
# Globals
Atoms = @Atoms =
  version   : "0.0.1"
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  $         : (args...) -> if $$? then $$ args... else $ args...

$ ->
  # # Example of Atoms
  # new Atoms.Atom.Button
  #   label       : "Login"
  #   molecule    : document.body
  #   method      : "prepend"

  # _input = new Atoms.Atom.Input
  #   type        : "password"
  #   placeholder : "Type your password"
  #   molecule    : document.body
  #   method      : "prepend"

  # _input = new Atoms.Atom.Input
  #   type        : "text"
  #   placeholder : "Type your name"
  #   molecule    : document.body
  #   method      : "prepend"


  # # Example of Molecules
  # new Atoms.Molecule.Search
  #   organism: "section"

  # new Atoms.Molecule.Search
  #   organism: "section"
  #   label   : "buscar"
  #   atoms:
  #     input:
  #       placeholder: "buscador your search"
  #     button:
  #       label: "buscar"

  new Atoms.Organism.SearchableList system: "section"

