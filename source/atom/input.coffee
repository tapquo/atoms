###
@TODO

@namespace Atoms.Atom
@class Input

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Atom.Input extends Atoms.Core.Class.Atom

  @template """
    {{#if.label}}<label>{{label}}</label>{{/if.label}}
    <input type="{{type}}" name="{{name}}" placeholder="{{placeholder}}" class="{{style}}" value="{{value}}" {{#required}}required{{/required}} />"""

  @events "click", "keypress", "keyup"
