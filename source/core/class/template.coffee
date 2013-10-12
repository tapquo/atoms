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

  constructor: ->
    super
    @attributes.className = @className
    @type = "Template"
    @render()
