###
Basic Module with extend/include methods

@namespace Atoms.Core
@class Module

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

MODULE_KEYWORDS = ['included', 'extended']

class Atoms.Core.Module

  template: null
  parent  : null
  el      : null

  @extend: (obj) ->
    throw new Error('extend(obj) requires obj') unless obj
    @[key] = value for key, value of obj when key not in MODULE_KEYWORDS
    obj.extended?.apply(this)
    @

  @include: (obj) ->
    throw new Error('include(obj) requires obj') unless obj
    @::[key] = value for key, value of obj when key not in MODULE_KEYWORDS
    included = obj.included
    included.apply(this) if included
    @

  constructor: ->
    @init? arguments
    @className = @constructor.name
