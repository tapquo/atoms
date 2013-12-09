###
Basic fieldset for search

@namespace Atoms.Molecule
@class Navigation

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Navigation extends Atoms.Class.Molecule

  @template = """<nav class="{{style}}"></nav>"""

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
    if path is "aside"
      Atoms.Url.aside()
    else if path is "back"
      Atoms.Url.back()
    else if path?
      Atoms.Url.path path
