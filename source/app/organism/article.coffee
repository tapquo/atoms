
class Atoms.Organism.Article extends Atoms.Core.Class.Organism

  @template """
    <article {{#if.id}}id="{{id}}"{{/if.id}}></article>"""

  areas: ["header", "section", "footer"]


  constructor: ->
    super
    @el.bind "webkitAnimationEnd", @_onAnimationEnd


  in: ->
    # @TODO: Has a aside?
    @
  out: -> @
  backIn: -> @
  backOut: -> @

  state: (name) ->
    @el.addClass("active").attr("data-state", name)

  section: (id) ->
    @el.children("##{id}").addClass("active").siblings().removeClass("active")

  _onAnimationEnd: (event) =>
    state = @el.attr "data-state"
    @el.removeAttr "data-state"

    unless state in ["in", "back-out"] then @el.removeClass "active"

