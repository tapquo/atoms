###
Basic Module with extend/include methods

@namespace Atoms.Core
@class Module

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

MODULE_KEYWORDS = ['included', 'extended']

class Atoms.Core.Module

  constructor: -> @id = guid()

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
  @method template
  @param  {value}    String or Function
  ###
  @template = (value) ->
    if value? and typeof value is "string"
      @template = value
    else
      @template = "<div/>"

guid = ->
  'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
    r = Math.random() * 16 | 0
    v = if c is 'x' then r else r & 3 | 8
    v.toString 16
  .toUpperCase()
