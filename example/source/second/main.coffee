class Atoms.App.Section.Main extends Atoms.Organism.Section

  @scaffold "source/second/main.yml"

  buttonClick: ->
    modal = new Atoms.Organism.Modal
      icon    : "question"
      title   : "Hello modal"
      text    : "lorem ipsum"
    modal.show()
