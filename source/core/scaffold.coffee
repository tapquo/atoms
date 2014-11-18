###
Attributes mixer

@namespace Atoms.Core
@class Attributes

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Scaffold =

  ###
  Set the parent instance to current instance.
  @method scaffold
  ###
  scaffold: ->
    @attributes = Atoms.Core.Helper.mix @attributes, @constructor.default

    @parent = {}
    if @attributes?.parent?
      @parent = @attributes.parent
      delete @attributes.parent

    @container = @attributes.container or @parent.el or document.body
    delete @attributes.container if @attributes?.container?

    if @attributes?.entity?
      @entity = @attributes.entity
      delete @attributes.entity
