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

    if atom.attributes.system?
      system = atom.attributes.system

      if system.article? then Atoms.System.Layout.show system.article
      if system.url? then Atoms.System.Layout.back()
      if system.aside? then Atoms.System.Layout.aside()
