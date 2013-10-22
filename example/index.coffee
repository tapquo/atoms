$ ->
  console.log "------------------------------------------------------------"
  console.log "Atoms v#{Atoms.version}", Atoms
  console.log "------------------------------------------------------------"

  # ------------------------------------------------------------
  # Molecule examples
  # ------------------------------------------------------------
  # search = new Atoms.Molecule.Search
  #   parent: "article section"
  #   # atoms : [
  #   #   input: placeholder: "Your password..."
  #   # ,
  #   #   button: icon: "plus", text: null
  #   # ]
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


  # ------------------------------------------------------------
  # Organism Article
  # ------------------------------------------------------------
  class First extends Atoms.Organism.Article

    @scaffold "organisms/article.yml"

    navigationSelect: (event, atom, molecule) ->
      console.log "event", event
      console.log "atom", atom
      console.log "molecule", molecule

    formKeyup: (event) -> console.log "ku", event

    formKeypress: (event) -> console.log "kp", event

    formClick: (event, atom, molecule) -> console.log "value: ", molecule.value()

    buttonClick: (event) -> console.log "Atom.Button clicked"

  first = new First parent: document.body

  first.el.addClass "aside"
  Atoms.System.Layout.show "First"

  # ------------------------------------------------------------
  # Organism Aside
  # ------------------------------------------------------------
  class Aside extends Atoms.Organism.Aside

    @scaffold "organisms/aside.yml"

  aside = new Aside parent: document.body

  # ------------------------------------------------------------
  # Template
  # ------------------------------------------------------------
  # session = new Atoms.Template.LungoSession
  #   parent    : document.body
  #   # title     : "Atoms App"
  #   # logo      : "http://cdn.tapquo.com/photos/soyjavi.jpg"
  #   # copyright : "Tapquo S.L. 2013"
  #   # inputs    : [
  #   #   placeholder: "Tu usuario...",
  #   #   value: "@soyjavi",
  #   #   name: "nombre"
  #   # ,
  #   #   placeholder: "Your password...",
  #   #   name: "contraseña"
  #   # ]

