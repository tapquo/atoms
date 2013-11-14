class Second extends Atoms.Organism.Article
  @scaffold "source/second/second.yml"

  instance: ->
    super
    new Atoms.App.Section.Main {parent: @el}, instance = true, "source/second/main.yml"


second = new Second parent: document.body
