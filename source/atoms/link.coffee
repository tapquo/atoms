###
@TODO

@namespace Atoms.Atom
@class Link

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Link extends Atoms.BaseAtom

  template: """
    <a href="{{href}}" class="{{class}}" data-icon="{{icon}}" data-method="{{method}}">{{label}}</a>
    """

  events: ["click"]
