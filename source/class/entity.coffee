###
Constants

@namespace Atoms.Core
@class Constants

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Entity extends Atoms.Core.Module

  @extend Atoms.Core.Event
  @records : {}
  @attributes: []

  @fields: (attributes...) ->
    @records    = {}
    @attributes = if attributes.length then attributes else []
    @unbind()
    @

  # Static Methods

  # Instance Methods
  constructor: (attributes) ->
    super
    @className = @constructor.name
    @uid = @constructor.uid()




# Utilities & Shims
unless typeof Object.create is 'function'
  Object.create = (o) ->
    Func = ->
    Func.prototype = o
    new Func()
