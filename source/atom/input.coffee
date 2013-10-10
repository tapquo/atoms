###
@TODO

@namespace Atoms.Atom
@class Input

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Input extends Atoms.Class.Atom

  template: """
    {{#if.label}}<label>{{label}}</label>{{/if.label}}
    <input type="{{type}}" name="{{name}}" placeholder="{{placeholder}}" class="{{style}}" value="{{value}}" />"""

  events: ["click", "keypress", "keyup"]

  constructor: (@attributes) ->
    @attributes.if = label: false
    @attributes.if.label = true if @attributes.label?
    super

