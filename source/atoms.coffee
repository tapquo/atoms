
# Globals
Atoms = @Atoms =
  version   : "0.0.3"
  Class     : {}
  Core      : {}
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  # Core helpers
  className : (string) -> string.charAt(0).toUpperCase() + string.slice(1)
  isArray: (value) -> return {}.toString.call(value) is '[object Array]'
  $: (args...) -> if $$? then $$ args... else $ args...

$ ->
  console.log Atoms
  headerNavSearch = new Atoms.Organism.HeaderNavSearch parent: document.body

  # new Atoms.Organism.AsideMenu text: "sjsjsjsj", parent: document.body

  # new Atoms.Molecule.Search parent: document.body
  # new Atoms.Organism.SearchableList system: "section"

  # new Atoms.Molecule.Navigation
    # link: [
    #   href: "http://google.com", label: "Google", icon: "google"
    # ,
    #   href: "http://tapquo.com", label: "tapquo"
    # ,
    #   href: "http://w3c.com", label: "w3c", icon: "html5"],
  #   button: [
  #     label: "one"
  #   ,
  #     label: "two"],
  #   parent: document.body
