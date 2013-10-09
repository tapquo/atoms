
class Atoms.Organism.ArticleListSearchable extends Atoms.Class.Organism

  template: """<article organism-class="{{className}}"></article>"""

  molecules:
    search: {}
  #   list: {}

  bindings:
    search: ["enter"]
    list: ["click"]

  searchEnter: (value) ->
    console.log value

  listClick: (atom) ->
    console.log "listClick", atom
