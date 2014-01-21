###
Base class for Organism

@namespace Atoms.Class
@class Organism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Organism extends Atoms.Core.Module

  @include Atoms.Core.Event
  @include Atoms.Core.Output

  #@TODO: Better if I use a instance variable. Change It!
  yaml = undefined

  @scaffold: (url) ->
    loader = if $$? then $$ else $
    scaffold = loader.ajax
      url     : url
      async   : false
      dataType: "text"
      error   : -> throw "Error loading scaffold in #{url}"
    yaml = YAML.parse scaffold.responseText

  constructor: (@attributes, scaffold) ->
    super
    if scaffold then yaml = @_getScaffold(scaffold)
    @attributes = Atoms.Core.Helper.mix @attributes, yaml
    yaml = undefined
    @constructor.type = @constructor.type or "Organism"

  render: ->
    do @output
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

          attributes = child[attribute]
          attributes.parent = @
          instance = new classInstance attributes
          @[className].push instance

          if attributes.events? then @bindList instance, attributes.events

  _getScaffold: (url) ->
    loader = if $$? then $$ else $
    scaffold = loader.ajax
      url     : url
      async   : false
      dataType: "text"
      error   : -> throw "Error loading scaffold in #{url}"
    yaml = YAML.parse scaffold.responseText
