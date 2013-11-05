
class Atoms.Organism.Article extends Atoms.Core.Class.Organism

  @template """
    <article {{#if.id}}id="{{id}}"{{/if.id}}></article>"""

  areas: ["header", "section", "footer"]


  constructor: ->
    super
    @el.bind "webkitAnimationEnd", @_onAnimationEnd


  in: ->
    # @TODO: Has a aside?
    @state "in"
  out: -> @state "out"
  backIn: -> @state "back-in"
  backOut: -> @state "back-out"

  state: (name) ->
    @el.addClass("active").attr("data-state", name)

  section: (id) ->
    @el.children("##{id}").addClass("active").siblings().removeClass("active")

  aside: (id) ->
    state = @el.attr("data-state")
    @el.removeAttr("data-state")
    setTimeout =>
      @state if state is "aside-in" then "aside-out" else "aside-in"
    , 0

  _onAnimationEnd: (event) =>
    state = @el.attr "data-state"
    @el.removeAttr "data-state" unless state in ["aside-in"]

    unless state in ["in", "back-out", "aside-in", "aside-out"] then @el.removeClass "active"
