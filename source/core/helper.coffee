###
@TODO

@namespace Atoms.Core
@class Helper

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Helper = do ->

  mix = (extend, base) ->
    result = @_clone(base)
    if result? then result[prop] = extend[prop] for prop of extend else result = extend
    result


  className = (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)


  isArray = (value) ->
    return {}.toString.call(value) is '[object Array]'


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
  className : className
  isArray   : isArray
