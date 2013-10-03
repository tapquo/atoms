###
@TODO

@namespace Atoms.Atom
@class Button

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Button extends Atoms.BaseAtom

  template: """
    <atom-button>
        <button id="{{id}}">
        {{label}}
        </button>
    </atom-button>"""

  events: ["click"]
