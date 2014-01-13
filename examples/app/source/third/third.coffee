class Third extends Atoms.Organism.Article
  @scaffold "source/third/third.yml"

  constructor: ->
    super

third = new Third parent: document.body
