###
Base class for Organism

@namespace Atoms
@class BaseOrganism

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Organism extends Atoms.Core.Module

  @include Atoms.Core.EventEmitter
  @include Atoms.Core.Chemistry

  molecules : {}

  constructor: (@attributes) ->
    super
    @attributes.className = @className
    @type = "Organism"
    @el = Atoms.$ Atoms.Core.render(@template)(@attributes) unless @el
    @chemistry()
