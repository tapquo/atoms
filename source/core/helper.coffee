###
@TODO

@namespace Atoms.Core
@class Helper

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Helper = do ->

  ###
  Copy from any number of objects and mix them all into a new object.
  @method mix
  @param  {object} arguments to mix them all into a new object.
  @return {object} child a new object with all the objects from the arguments
                   mixed.
  ###
  mix = (extend, base) ->
    clone = @_clone base
    # if clone? then clone[prop] = extend[prop] for prop of extend else clone = extend
    if clone?
      for property of extend
        if typeof(extend[property]) is "object"
          clone[property] = @mix extend[property], clone[property]
        else
          clone[property] = extend[property]
    else
      clone = extend
    clone

  ###
  Test if a given value it's a array type.
  @method isArray
  @param  {value}     Value to test.
  @return {boolean}   True if it's, false if not.
  ###
  isArray = (value) ->
    return {}.toString.call(value) is '[object Array]'

  # Private Methods
  _clone: (obj) ->
    return obj if not obj? or typeof obj isnt 'object'
    return new Date(obj.getTime()) if obj instanceof Date

    if obj instanceof RegExp
      flags = ''
      flags += 'g' if obj.global?
      flags += 'i' if obj.ignoreCase?
      flags += 'm' if obj.multiline?
      flags += 'y' if obj.sticky?
      return new RegExp(obj.source, flags)

    newInstance = new obj.constructor()
    newInstance[key] = @_clone obj[key] for key of obj
    newInstance

  mix       : mix
  isArray   : isArray

###
String prototype: capitalize first letter of a String
@method className
@return {string}    String capitalizated.
###
String.prototype.toClassName = ->
  @charAt(0).toUpperCase() + @slice(1)
