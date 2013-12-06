###
...

@namespace Atoms.Organism
@class Aside

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.Aside extends Atoms.Core.Class.Organism

  @template = """<aside></aside>"""

  constructor: (@attributes)->
    attributes.method = "prepend"
    super
    Atoms.App.Aside[@constructor.name] = @

  render: ->
    super
    @el.bind Atoms.Core.Constants.ANIMATION.END, @_onAnimationEnd


  in: ->
    unless @el then @render()
    @el.addClass "active"
    @el.attr "data-state", "in"

  out: ->
    @el?.removeClass "active"

  _onAnimationEnd: (event) =>
    state = @el.attr "data-state"
