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
    new Atoms.App.Section.Form {klass: @}, "source/first/form.yml"

  _log: (method, event) -> console.log "article > #{method}", event

  event_form_submit: (event, form, hierarchy...) ->
    console.info "event_form_submit", form.value()

first = new First()
