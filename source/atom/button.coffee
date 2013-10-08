###
@TODO

@namespace Atoms.Atom
@class Button

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Button extends Atoms.Class.Atom

  template: """
    <button id="{{id}}" class="{{style}}" data-icon="{{icon}}">
    {{text}}
    </button>"""

  events: ["click"]
