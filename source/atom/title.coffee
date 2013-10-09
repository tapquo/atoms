###
@TODO

@namespace Atoms.Atom
@class Title

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Title extends Atoms.Class.Atom

  template: """<h1>{{text}}</h1>"""

  events: ["click"]
