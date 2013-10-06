###
@TODO

@namespace Atoms
@class Output

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Output =

  append: -> @render "append"

  prepend: -> @render "prepend"

  html: -> @render "html"

  render: (method) ->
    @el = Atoms.$ Atoms.Core.render(@template)(@attributes)
    @parent[method] @el
