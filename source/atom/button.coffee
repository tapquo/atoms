###
@TODO

@namespace Atoms.Atom
@class Button

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Button extends Atoms.Class.Atom

  template: """
    <button id="{{id}}" class="{{style}}">
      {{#if.icon}}<span class="icon {{icon}}"></span>{{/if.icon}}
      {{#if.text}}<abbr>{{text}}</abbr>{{/if.text}}
    </button>"""

  events: ["click"]

  constructor: (@attributes) ->
    @attributes.if = icon: false, text: false
    @attributes.if.icon = true if @attributes.icon?
    @attributes.if.text = true if @attributes.text?
    super

