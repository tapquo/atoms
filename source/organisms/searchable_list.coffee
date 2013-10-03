

class Atoms.Organism.SearchableList extends Atoms.BaseOrganism

  template:
    """<organism-searchabelist></organism-searchabelist>"""

  molecules:
    search:
      label       : "Buscador"
      binds       : ["search_on", "search_off"]

  search_on: (event) =>
    @search.el.removeAttr "style"

  search_off: (event) =>
    @search.el.attr "style", "background-color: red;"

