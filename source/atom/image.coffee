###
@TODO

@namespace Atoms.Atom
@class Button

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"


class Atoms.Atom.Image extends Atoms.Core.Class.Atom

  @template """
    <img src="{{source}}" class="{{style}}" alt="{{alt}}" />"""

  events: ["click"]
