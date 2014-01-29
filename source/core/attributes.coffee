###
HTML Renderer

@namespace Atoms.Core
@class Attributes

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Attributes =

  ###
  Set the parent instance to current instance.
  @method setParent
  ###
  scaffold: ->
    @parent = {}
    if @attributes?.parent?
      @parent = @attributes.parent
      delete @attributes.parent
    @parent.el = @parent.el or document.body

    if @attributes?.entity?
      @entity = @attributes.entity
      delete @attributes.entity
