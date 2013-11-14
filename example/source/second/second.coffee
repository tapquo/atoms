class Second extends Atoms.Organism.Article
  @scaffold "source/second/second.yml"

  render: ->
    super
    new Atoms.App.Section.Main {parent: @el}, "source/second/main.yml"


second = new Second parent: document.body
