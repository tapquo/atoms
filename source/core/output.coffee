###
@TODO

@namespace Atoms
@class Output

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Output =

  method: "append"

  append: -> @render "append"

  prepend: -> @render "prepend"

  html: -> @render "html"

  render: ->
    throw "No template defined." unless @template?
    throw "No parent assigned." unless @attributes.parent?

    @el = Atoms.$ Atoms.Core.render(@template)(@attributes)
    @parent = Atoms.$ @attributes.parent
    @method = @attributes.method if @attributes.method?
    @parent[@method] @el
