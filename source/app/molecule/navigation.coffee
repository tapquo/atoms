class Atoms.Molecule.Navigation extends Atoms.Core.Class.Molecule

  @template """<nav class="{{style}}"></nav>"""

  available: ["button", "link"]

  constructor: ->
    @default =
      events:
        link:   ["click"]
        button: ["click"]
    super

  linkClick: (event, atom) =>
    @_trigger event, atom

  buttonClick: (event, atom) =>
    @_trigger event, atom

  _trigger: (event, atom) ->
    event.preventDefault()
    atom.el.addClass("active").siblings().removeClass("active")
    @trigger "select", event, atom

    path = atom.attributes.path

    if path is "back"
      Atoms.System.Layout.back()
    else
      Atoms.Url.path path
