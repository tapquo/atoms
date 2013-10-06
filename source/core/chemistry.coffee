###
Event emitter which provides the observer pattern to Atoms classes.

@namespace Atoms.Core
@class Children

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Chemistry =

  chemistry: ->
    # Assign parent
    if @attributes.parent?
      @parent = Atoms.$ @attributes.parent
      method = if @attributes.method? then @attributes.method else "append"
      @parent[method] @el

    # Define context & type
    context = if @atoms? then "atoms" else "molecules"
    type = if @atoms? then "Atom" else "Molecule"

    # Read Attributes
    for attr of @attributes
      className = Atoms.Core.className(attr)
      if Atoms[type][className]?
        @attributes[attr] = [@attributes[attr]] unless Atoms.Core.isArray @attributes[attr]
        base = @[context][attr]
        @[context][attr] = []
        @[context][attr].push @_mix(item, base) for item in @attributes[attr]

    # Normalize values
    for index of @[context]
      className = Atoms.Core.className(index)
      if Atoms[type][className]?
        item = @[context][index]
        item = [item] unless Atoms.Core.isArray item
        @[index] = []
        @[index].push @_instance(type, className, child) for child in item

  _instance: (type, className, attributes) ->
    attributes.parent = @el
    instance = new Atoms[type][className] attributes
    if @bindings?[className.toLowerCase()]?
      className = className.toLowerCase()
      for event in @bindings[className]
        instance.bind event, @["#{className}#{Atoms.Core.className(event)}"]
    instance

  _mix: (a, base={}) ->
    base[property] = a[property] for property of a
    base
