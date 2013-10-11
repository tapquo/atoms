###
Base class for Molecule

@namespace Atoms.Core.Class
@class Molecule

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Core.Class.Molecule extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Output

  constructor: (@attributes) ->
    super
    @attributes.className = @className
    @type = "Molecule"
    @render()
    @atoms = {} unless @atoms?
    @chemistry()


  chemistry: (elements) ->
    # Read Attributes
    for attr of @attributes
      className = Atoms.Core.className(attr)
      if Atoms.Atom[className]? and @atoms[attr]?
        @attributes[attr] = [@attributes[attr]] unless Atoms.Core.isArray @attributes[attr]
        base = @atoms[attr]
        @atoms[attr] = (@_mix(item, base) for item in @attributes[attr])

    # Normalize values
    for index of @atoms
      @[index] = null
      className = Atoms.Core.className(index)
      if Atoms.Atom[className]?
        item = @atoms[index]
        item = [item] unless Atoms.Core.isArray item
        @[index] = (@_instance(className, child) for child in item)


  _instance: (className, attributes) ->
    attributes.parent = @el
    instance = new Atoms.Atom[className] attributes
    if @bindings?[className.toLowerCase()]?
      @bindList instance, className, @bindings[className.toLowerCase()]
    instance


  _mix: (extend, base) ->
    result = @_clone(base)
    if result? then result[prop] = extend[prop] for prop of extend else result = extend
    result


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
