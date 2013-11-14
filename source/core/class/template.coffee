###
Base class for Organism

@namespace Atoms.Core.Class
@class Template

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Core.Class.Template extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Output

  @attributes: (@elements...) -> @


  constructor: (@attributes) ->
    super
    @constructor.type = "Template"

    for key of @attributes
      if key in @constructor.elements
        @_mixAttributes(key)
      else if key isnt "parent"
        delete @attributes[key]

    for key in @constructor.elements
      @attributes[key] = @[key] unless @attributes[key]?
    @render()
    Atoms.App.Template[@constructor.name] = @


  _mixAttributes: (key)->
    if Atoms.Core.Helper.isArray(@attributes[key])
      for extend, index in @attributes[key]
        @[key][index] = Atoms.Core.Helper.mix extend, @[key][index]
    else if typeof(@attributes[key]) is "object"
      @[key] = Atoms.Core.Helper.mix @attributes[key], @[key]
    else
      @[key] = @attributes[key]
