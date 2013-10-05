###
@TODO

@namespace Atoms.Atom
@class Button

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Button extends Atoms.BaseAtom

  template: """
    <button id="{{id}}" class="{{style}}" data-icon="{{icon}}">
    {{label}}
    </button>"""

  events: ["click"]
