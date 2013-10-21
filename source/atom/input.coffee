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

  value: (value) ->
    input = @el.filter("input")
    if value? then input.val value else input.val()

  error: (value) ->
    if value?
      @el.filter("input").addClass "error"
    else
      @el.filter("input").removeClass "error"
