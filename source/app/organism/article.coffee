###
...

@namespace Atoms.Organism
@class Article

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.Article extends Atoms.Class.Organism

  @template = """
    <article {{#if.id}}id="{{id}}"{{/if.id}} {{#if.style}}class="{{style}}"{{/if.style}}></article>"""

  constructor: ->
    super
    Atoms.App.Article[@constructor.name] = @

  render: ->
    super
    @el.bind Atoms.Core.Constants.ANIMATION.END, @_onAnimationEnd

  in: ->
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
    @el.children("##{id}").addClass("active").siblings("section").removeClass("active")
    @aside() if @el.attr("data-state") is "aside-in"

  aside: ->
    state = @el.attr("data-state")
    if @attributes.aside?
      method = (if state? then "out" else "in")
      do Atoms.App.Aside[@attributes.aside][method]
    @el.removeAttr("data-state")
    setTimeout =>
      @state if state is "aside-in" then "aside-out" else "aside-in"
    , 0

  _onAnimationEnd: (event) =>
    state = @el.attr "data-state"
    @trigger state
    if state in ["in", "back-out"]
      @trigger "active"
    else if state in ["out", "back-in"]
      @trigger "inactive"
    @el.removeAttr "data-state" unless state in ["aside-in"]

    unless state in ["in", "back-out", "aside-in", "aside-out"] then @el.removeClass "active"
