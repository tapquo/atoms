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

    # Example of Async Process Render
    Atoms.Entity.Contact.create name: "@soyjavi", description: "Test", url: "sjsjjs"
    Atoms.Entity.Contact.create name: "@piniphone", description: "Test 2", when: new Date()
    Atoms.Entity.Contact.create name: "@tapquo"

    list.entityAtom "Li"
    list.entity Atoms.Entity.Contact.all()


  _log: (method, event) -> console.log "article > #{method}", event

  bubbleFormSubmit: (event, form, hierarchy...) ->
    console.info "<article> bubbleFormSubmit", form.value()

first = new First()


class Atoms.Entity.Contact extends Atoms.Class.Entity

  @fields "id", "name", "description", "url", "when"

  text: ->
    @name
