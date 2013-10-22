###
@TODO

@namespace Atoms.Atom
@class Label

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Title extends Atoms.Core.Class.Atom

  @template """
    <h1>
      {{#if.image}}<img src="image" />{{/if.image}}
      {{#if.text}}{{text}}{{/if.text}}
    </h1>"""
