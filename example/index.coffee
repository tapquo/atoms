$ ->
  console.log "------------------------------------------------------------"
  console.log "Atoms v#{Atoms.version}", Atoms
  console.log "------------------------------------------------------------"

  # class ButtonBig extends Atoms.Atom.Button

  #   constructor: ->
  #     @constructor.template = "<button class='big'><span class='icon profile'></span>{{text}}</button>"
  #     super

  # attributes = parent: "article section", text: "ButtonExt", value: "Button"
  # inputext = new ButtonBig attributes
  # input = new Atoms.Atom.Button attributes
  # console.log input.constructor.name, inputext.constructor.__super__.constructor.name

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
  #   # style : "clase"
  #   atoms : [
  #     label: text: "prueba"
  #   ,
  #     input: type: "text", name: "name", placeholder: "Your name...", style: "big"
  #   ,
  #     input: type: "password", name: "password", placeholder: "Your password..."
  #   ,
  #     label: text: "prueba"
  #   ,
  #     button: icon: "plus", text: "Save", style: "fluid accept"
  #   ,
  #     button: icon: "profile", text: "prieba", style: "fluid cancel", disabled: true
  #   ]
  #   # events:
  #   #   input: ["keyup"]
  #   triggers: ["keypress", "keyup", "click"]

  # form.bind "keyup", (event) ->
  #   console.log "keyupped", event


  # form.bind "click", (event) ->
  #   console.log "clicked", event


  # nav = new Atoms.Molecule.Navigation
  #   parent: "article footer"
  #   style: "right"
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

  # first.el.addClass "aside"
  Atoms.System.Layout.show "First"

  # ------------------------------------------------------------
  # Organism Aside
  # ------------------------------------------------------------
  # class Aside extends Atoms.Organism.Aside
  #   @scaffold "organisms/aside.yml"

  # aside = new Aside parent: document.body

  # # ------------------------------------------------------------
  # # Template
  # # ------------------------------------------------------------
  # session = new Atoms.Template.Session
  #   parent    : document.body
  #   title     : "Atoms App"
  #   logo      : "http://cdn.tapquo.com/photos/soyjavi.jpg"
  #   copyright : "Tapquo S.L. 2013"
  #   inputs    : [
  #     placeholder: "Nickname...",
  #     value: "@soyjavi",
  #     name: "nickname"
  #   ,
  #     name: "pass"
  #   ]
