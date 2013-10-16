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

  ###
  Extends the contents of an object onto the class to provide new static methods.
  @method extend
  @param  {value}    Contents
  ###
  @extend: (obj) ->
    throw new Error('extend(obj) requires obj') unless obj
    @[key] = value for key, value of obj when key not in MODULE_KEYWORDS
    obj.extended?.apply(this)
    @

  ###
  Include the contents of an object onto the class prototype to provide new
  instance methods.
  @method include
  @param  {value}    Contents
  ###
  @include: (obj) ->
    throw new Error('include(obj) requires obj') unless obj
    @::[key] = value for key, value of obj when key not in MODULE_KEYWORDS
    included = obj.included
    included.apply(this) if included
    @

  ###
  ...
  @method create
  @param  {value}    Instance extend contents
  @param  {value}    Static extend contents
  ###
  @create: (instances, statics) ->
    class cls extends @
    cls.include(instances) if instances
    cls.extend(statics) if statics
    cls

  ###
  ...
  @method conditionals
  @param  {array}    Array of conditionals values for template.
  ###
  @conditionals: (@ifs...) -> @

  constructor: ->
    @init? arguments
    @className = @constructor.name
