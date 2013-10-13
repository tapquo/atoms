###
HTML Renderer

@namespace Atoms.Core
@class Output

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Output =

  method: "append"
  ifs   : []

  ###
  Insert content to the end of each element in the set of matched elements.
  @method append
  ###
  append: -> @render "append"

  ###
  Insert content to the beginning of each element in the set of matched elements.
  @method prepend
  ###
  prepend: -> @render "prepend"

  ###
  Set the HTML contents of each element in the set of matched elements.
  @method html
  ###
  html: -> @render "html"

  ###
  Render element with the instance @template and @attributes.
  @method render
  ###
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
