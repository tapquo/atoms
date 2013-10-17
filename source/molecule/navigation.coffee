class Atoms.Molecule.Navigation extends Atoms.Core.Class.Molecule

  @template """
    <nav molecule-class="{{className}}" class="{{style}}"></nav>
  """

  bindings:
    link:   ["click"]
    button: ["click"]

  constructor: ->
    @atoms = link: [], button: []
    super

  linkClick: (event, atom) =>
    @_trigger event, atom

  buttonClick: (event, atom) =>
    @_trigger event, atom

  _trigger: (event, atom) ->
    event.preventDefault()
    atom.el.addClass("active").siblings().removeClass("active")
    @trigger "select", event, atom

