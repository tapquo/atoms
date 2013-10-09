
# Globals
Atoms = @Atoms =
  version   : "0.0.3"
  Class     : {}
  Core      :
    className : (string) -> string.charAt(0).toUpperCase() + string.slice(1)
    isArray   : (value) -> return {}.toString.call(value) is '[object Array]'
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  System    : {}
  # Core helpers
  $: (args...) -> if $$? then $$ args... else $ args...

$ ->
  # new Atoms.Molecule.Navigation
  #   parent: "aside header"
  #   style: "right"
  #   link: [
  #     href: "prueba", text: "a"
  #   ,
  #     href: "prueba", text: "b"]
  #   button: [
  #     icon: "user", text: "c"
  #   ,
  #     icon: "user", text: "d"
  #   ]


  # new Atoms.Molecule.Navigation
  #   parent: "aside header"
  #   style: "left"
  #   # link: [
  #   #   href: "prueba", text: "1"
  #   # ,
  #   #   href: "prueba", text: "2"]
  #   button: [
  #     icon: "user", text: "3"
  #   ,
  #     icon: "user", text: "4"
  #   ]


  # headerNavSearch = new Atoms.Organism.HeaderNavSearch parent: document.body
  new Atoms.Organism.HeaderNavigation
    parent: "aside"
    title: "Testing"
    navigation: [
      style: "right"
      link: [
        href: "prueba", text: "a"
      ,
        href: "prueba", text: "b"]
      button: [
        icon: "share"
      ,
        icon: "pencil"
      ,
        text: "user"
      ]
    ,
      style: "left"
      button: [
        icon: "home"
      ]
    ]


  new Atoms.Molecule.Search
    parent: "aside section"
    label: text: "Buscar:"
    button: text: "Vamos!"
    link: href: "#", text: "sksksk"

  new Atoms.Molecule.Search parent: "aside section"

  new Atoms.Atom.Button parent: "aside section", icon: "user", text: "fluid", style: "fluid"
  new Atoms.Atom.Button parent: "aside section", icon: "user", text: "big", style: "big accept"
  new Atoms.Atom.Button parent: "aside section", icon: "user", text: "small", style: "small cancel"
  new Atoms.Atom.Button parent: "aside section", icon: "user", text: "tiny", style: "tiny warning"

  new Atoms.Molecule.Navigation
    parent: "aside section"
    button: [
      icon: "user"
    ,
      icon: "user", text: "User", style:"disabled"
    ,
      text: "user"
    ]

  new Atoms.Molecule.Navigation
    parent: "aside section"
    button: [
      icon: "ok-sign", style: "accept"
    ,
      icon: "warning-sign", style: "warning"
    ,
      icon: "remove-sign", style: "cancel"
    ]

  footer = new Atoms.Molecule.Navigation
    parent: "aside footer"
    button: [
      icon: "user"
    ,
      icon: "user", text: "User"
    ,
      text: "user"
    ]
  footer.bind "select", (event, molecule) -> console.log event, molecule

  # new Atoms.Organism.ArticleListSearchable
  #   parent: "section"
  #   list:
  #     li: [
  #       text: "one"
  #     ,
  #       text: "two"
  #     ,
  #       text: "three"]
