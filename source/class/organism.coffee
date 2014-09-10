###
Base class for Organism

@namespace Atoms.Class
@class Organism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Organism extends Atoms.Core.Module

  @include Atoms.Core.Scaffold
  @include Atoms.Core.Children
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  @type = "Organism"

  @scaffold: (@url) -> @

  ###
  Prepare Organism instance
  @method constructor
  @param  attributes  OBJECT
  @param  scaffold    STRING
  ###
  constructor: (@attributes, url = @constructor.url) ->
    super
    @children = []
    if url
      loader = if $$? then $$ else $
      scaffold = loader.ajax
        url     : url
        async   : false
        dataType: "text"
        error   : -> throw "Error loading scaffold in #{url}"
      if scaffold.status is 200
        scaffold = JSON.parse scaffold.responseText
        @attributes = Atoms.Core.Helper.mix @attributes, scaffold

  ###
  Render element with custom template and instance all Atom/Molecule children.
  @method render
  ###
  render: ->
    do @scaffold
    do @output
    do @chemistry
