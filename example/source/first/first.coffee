class First extends Atoms.Organism.Article

    @scaffold "source/first/first.yml"

    constructor: ->
      super
      # @bind "in", (event) -> console.log "in", event
      # @bind "active", (event) -> console.log "active", event
      # @bind "inactive", (event) -> console.log "inactive", event

    render: ->
      super
      new Atoms.App.Section.Form {parent: @el}, "source/first/form.yml"

first = new First parent: document.body
