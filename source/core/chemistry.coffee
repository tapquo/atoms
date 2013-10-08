###
Event emitter which provides the observer pattern to Atoms classes.

@namespace Atoms.Core
@class Children

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Chemistry =

  chemistry: (elements) ->
    # Assign parent
    if @attributes.parent?
      @parent = Atoms.$ @attributes.parent
      method = if @attributes.method? then @attributes.method else "append"
      @parent[method] @el

    # Define context & type
    context = if @type is "Molecule" then "atoms" else "molecules"
    @[context] = {} unless @[context]?
    type = if @type is "Molecule" then "Atom" else "Molecule"

    # Read Attributes
    for attr of @attributes
      className = Atoms.Core.className(attr)
      if Atoms[type][className]? and @[context][attr]?
        @attributes[attr] = [@attributes[attr]] unless Atoms.Core.isArray @attributes[attr]
        base = @[context][attr]
        @[context][attr] = (@_mix(item, base) for item in @attributes[attr])

    # Normalize values
    for index of @[context]
      @[index] = null
      className = Atoms.Core.className(index)
      if Atoms[type][className]?
        item = @[context][index]
        item = [item] unless Atoms.Core.isArray item
        @[index] = (@_instance(type, className, child) for child in item)


  _instance: (type, className, attributes) ->
    attributes.parent = @el
    instance = new Atoms[type][className] attributes
    if @bindings?[className.toLowerCase()]?
      className = className.toLowerCase()
      for event in @bindings[className]
        instance.bind event, @["#{className}#{Atoms.Core.className(event)}"]
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
