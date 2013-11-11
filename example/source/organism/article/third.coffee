class Third extends Atoms.Organism.Article
  @scaffold "source/organism/article/third.yml"

  constructor: ->
    super

third = new Third parent: document.body
