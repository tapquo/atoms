class Options extends Atoms.Organism.Aside
  @scaffold "source/aside/default.yml"

  constructor: ->
    super
    @bind "in", (event) -> @_log "in", event
    @bind "out", (event) -> @_log "out", event

  _log: (method, event) -> console.log "aside > #{method}", event

aside = new Options()
