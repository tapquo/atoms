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
    new Atoms.App.Section.Form {parent: @el}, "source/first/form.yml"

  _log: (method, event) -> console.log "article > #{method}", event


first = new First parent: document.body
