###
Base class for Organism

@namespace Atoms.Class
@class Organism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Organism extends Atoms.Core.Module

  @include Atoms.Core.Attributes
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  #@TODO: Better if I use a instance variable. Change It!
  _file = undefined

  constructor: (@attributes, scaffold) ->
    super
    @default = children: [] unless @default
    @children = []
    @constructor.type = @constructor.type or "Organism"

    if scaffold then _file = @_getScaffold(scaffold)
    @attributes = Atoms.Core.Helper.mix @attributes, _file
    _file = undefined

  @scaffold: (url) ->
    loader = if $$? then $$ else $
    scaffold = loader.ajax
      url     : url
      async   : false
      dataType: "text"
      error   : -> throw "Error loading scaffold in #{url}"
    if YAML?
      _file = YAML.parse scaffold.responseText
    else
      _file = JSON.parse scaffold.responseText

  render: ->
    do @scaffold
    do @output
    do @chemistry

  _getScaffold: (url) ->
    loader = if $$? then $$ else $
    scaffold = loader.ajax
      url     : url
      async   : false
      dataType: "text"
      error   : -> throw "Error loading scaffold in #{url}"
    _file = YAML.parse scaffold.responseText
