class SecondMain extends Atoms.Organism.Section

  @scaffold "source/organism/section/main.yml"

  buttonClick: ->
    modal = new Atoms.Organism.Modal
      icon    : "question"
      title   : "Hello modal"
      text    : "lorem ipsum"
    modal.show()

secondMain = new SecondMain parent: second.el
