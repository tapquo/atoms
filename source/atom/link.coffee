###
@TODO

@namespace Atoms.Atom
@class Link

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Link extends Atoms.Core.Class.Atom

  template: """
    <a href="{{href}}" class="{{style}}" data-icon="{{icon}}">{{text}}</a>"""

  events: ["click"]
