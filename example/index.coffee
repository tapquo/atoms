Atoms.$ ->

  if navigator.standalone
    $(document.body).addClass "standalone"

  # window.addEventListener "popstate", (event) ->
  #   event.preventDefault()
  #   console.log "popstate", event, history.state

  # window.addEventListener "pushstate", (event) ->
  #   event.preventDefault()
  #   console.log "pushstate", event

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

    @scaffold "atoms/article/first.yml"

    navigationSelect: (event, atom, molecule) ->
      console.log "event", event
      console.log "atom", atom
      console.log "molecule", molecule

    formKeyup: (event) -> console.log "ku", event

    formKeypress: (event) -> console.log "kp", event

    formClick: (event, atom, molecule) -> console.log "value: ", molecule.value()

    buttonClick: (event) ->
      console.log "Atom.Button clicked"
      Atoms.System.Cache.Loading.show()
      setTimeout ->
        Atoms.System.Cache.Loading.hide()
      , 850


  first = new First parent: document.body


  class Second extends Atoms.Organism.Article
    @scaffold "atoms/article/second.yml"

    buttonClick: ->
      modal = new Atoms.Organism.Modal
        icon    : "question"
        title   : "Hello modal"
        text    : "lorem ipsum"
      modal.show()

  second = new Second parent: document.body


  class Third extends Atoms.Organism.Article
    @scaffold "atoms/article/third.yml"

    constructor: ->
      super
      @attributes.aside = "skksk"

  third = new Third parent: document.body

  # Atoms.Url.path "first", "second"
  # Atoms.Url.path "second", "second"
  # Atoms.Url.path "third", "second"


  # ------------------------------------------------------------
  # Organism Aside
  # ------------------------------------------------------------
  # class Aside extends Atoms.Organism.Aside
  #   @scaffold "organisms/aside.yml"

  # aside = new Aside parent: document.body


  # ------------------------------------------------------------
  # Organism Aside
  # ------------------------------------------------------------


  # Atoms.System.Cache.Loading.show()
  # setTimeout ->
  #   loading.hide()
  # , 1000

  # ------------------------------------------------------------
  # Template
  # ------------------------------------------------------------
  # session = new Atoms.Template.Session
  #   parent    : document.body
  #   title     : "Atoms App"
  #   logo      : "http://cdn.tapquo.com/photos/soyjavi.jpg"
  #   copyright : "Tapquo S.L. 2013"
  #   inputs: [
  #     input: placeholder: "Nickname...", value: "@soyjavi", name: "nickname"
  #   ,
  #     input: name: "pass"
  #   ]
  #   buttons: [
  #     button: style: "cancel", text: "Log in"
  #   ]

  # session.bind "validate", -> console.log "argu", arguments
  # Atoms.System.Layout.show "Session"
