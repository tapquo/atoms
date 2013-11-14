###
Base class for Organism

@namespace Atoms.Core.Class
@class Organism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Core.Class.Organism extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Output

  areas: []

  yaml = undefined

  @scaffold: (url) ->
    loader = if $$? then $$ else $
    response = loader.ajax
      url     : url
      async   : false
      dataType: "text"
      error   : -> throw "Error loading scaffold in #{url}"
      success : (response) -> yaml = YAML.parse(response)


  constructor: (@attributes) ->
    super
    @attributes = Atoms.Core.Helper.mix @attributes, yaml
    yaml = undefined
    @constructor.type = @constructor.type or "Organism"
    @render()
    if @attributes.children then @_createChildren()


  _createChildren: ->
    for child in @attributes.children
      for attribute of child
        className = attribute.split(".")
        type = className[0]
        className = className[1]

        classInstance = Atoms[type]?[className]

        if classInstance?
          @[className] = [] unless @[className]?

          obj = child[attribute]
          obj.parent = @el
          instance = new classInstance obj
          @[className].push instance

          if obj.events? then @bindList instance, obj.events
