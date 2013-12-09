###
Basic fieldset for search

@namespace Atoms.Molecule
@class Form

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Form extends Atoms.Class.Molecule

  @template = """<form {{#if.style}}style="{{style}}"{{/if.style}}></form>"""

  available: ["label", "input", "textarea", "select", "button"]

  constructor: ->
    @default =
      events:
        input   : ["keyup", "keypress"]
        button  : ["click"]
    super

  value: ->
    properties = {}
    properties[input.attributes.name] = input.value() for input in @input
    properties

  inputKeypress: (event, atom) =>
    @trigger "keypress", event.keyCode, atom

  inputKeyup: (event, atom) =>
    @trigger "keyup", event.keyCode, atom

  buttonClick: (event, atom) =>
    event.preventDefault()
    @trigger "click", event, atom
