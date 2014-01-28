class First extends Atoms.Organism.Article

  @scaffold "source/first/first.yml"

  constructor: ->
    super
    @bind "in", (event) -> @_log "in", event
    @bind "out", (event) -> @_log "out", event
    @bind "active", (event) -> @_log "active", event
    @bind "inactive", (event) ->  @_log "inactive", event

  render: ->
    super
    new Atoms.App.Section.Form  parent: @, "source/first/form.yml"

    list = new Atoms.Molecule.ListContacts
      parent  : el: @el.find("section#list")

    list.entity [
      name: "@soyjavi", description: "Test"
    ,
      name: "@piniphone", description: "Test 2"
    ,
      name: "@tapquo", description: "Test 3"
    ]

    # list.entity [name: "Javi"]


  _log: (method, event) -> console.log "article > #{method}", event

  bubbleFormSubmit: (event, form, hierarchy...) ->
    console.info "<article> bubbleFormSubmit", form.value()

first = new First()
