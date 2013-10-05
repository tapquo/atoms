class Atoms.Molecule.Navigation extends Atoms.BaseMolecule

  template: """
    <nav molecule-class="{{className}}" class="{{style}}"></nav>
  """

  bindings:
    link:   ["click"]
    button: ["click"]

  linkClick: (event, atom) => @_trigger event, atom

  buttonClick: (event, atom) => @_trigger event, atom

  _trigger: (event, atom) ->
    event.preventDefault()
    atom.el.addClass("active").siblings().removeClass("active")
    @trigger "select", atom, @
