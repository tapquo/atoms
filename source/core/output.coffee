###
@TODO

@namespace Atoms.COre
@class Output

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Output =

  method: "append"
  ifs   : []

  append: -> @render "append"

  prepend: -> @render "prepend"

  html: -> @render "html"

  render: ->
    throw "No template defined." unless @template?
    throw "No parent assigned." unless @attributes.parent?

    @_setIfBindings() if @ifs.length > 0
    @el = Atoms.$ Atoms.Core.render(@template)(@attributes)
    @parent = Atoms.$ @attributes.parent
    @method = @attributes.method if @attributes.method?
    @parent[@method] @el

  _setIfBindings: ->
    @attributes.if = {}
    for key in @ifs
      @attributes.if[key] = if @attributes[key]? then true else false
