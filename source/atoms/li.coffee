###
@TODO

@namespace Atoms.Atom
@class Li

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Li extends Atoms.BaseAtom

  template: """
    <li class="{{style}}">{{label}}</li>"""

  events: ["click"]
