###
@TODO

@namespace Atoms.Atom
@class Input

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Input extends Atoms.Class.Atom

  template: """
    <input type="{{type}}" id="{{id}}" placeholder="{{placeholder}}" class="{{style}}" value="{{value}}" />"""

  events: ["click", "keypress", "keyup"]
