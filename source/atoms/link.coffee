###
@TODO

@namespace Atoms.Atom
@class Link

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Link extends Atoms.BaseAtom

  template: """
    <atom-link>
        <a href="#" class="{{class}}" data-icon="{{icon}}">
          {{label}}
        </a>
    </atom-link>"""

  events: ["click"]
