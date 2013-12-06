###
...

@namespace Atoms.Organism
@class Article

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.Article extends Atoms.Core.Class.Organism

  @template = """
    <article {{#if.id}}id="{{id}}"{{/if.id}} {{#if.style}}class="{{style}}"{{/if.style}}></article>"""

  constructor: ->
    super
    Atoms.App.Article[@constructor.name] = @

  render: ->
    super
    @el.bind Atoms.Core.Constants.ANIMATION.END, @_onAnimationEnd

  in: ->
    # @TODO: Has a aside?
    @state "in"

  out: ->
    @state "out"

  backIn: ->
    @state "back-in"

  backOut: ->
    @state "back-out"

  state: (name) ->
    @el.addClass("active").attr("data-state", name)

  section: (id) ->
    @el.children("##{id}").addClass("active").siblings().removeClass("active")

  aside: (id) ->
    state = @el.attr("data-state")
    if state?
      Atoms.App.Aside[@attributes.aside].out()
    else
      Atoms.App.Aside[@attributes.aside].in()
    @el.removeAttr("data-state")
    setTimeout =>
      @state if state is "aside-in" then "aside-out" else "aside-in"
    , 0

  _onAnimationEnd: (event) =>
    state = @el.attr "data-state"
    @trigger state
    @trigger (if state in ["in", "back-out"] then "active" else "inactive")
    @el.removeAttr "data-state" unless state in ["aside-in"]

    unless state in ["in", "back-out", "aside-in", "aside-out"] then @el.removeClass "active"
