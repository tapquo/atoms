###
Base for Modals

@namespace Atoms.Molecule
@class Modal

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Modal extends Atoms.Class.Molecule

  @template = """
    <div data-component="modal">
      <article></article>
    </div>"""

  constructor: (@attributes={}) ->
    @attributes.parent = document.body
    super @attributes
    @article = @el.children("article")
    # @TODO: Test in QuoJS
    @article.bind Atoms.Core.Constants.ANIMATION.END, @onAnimationEnd
    Atoms.App.Modal[@constructor.name] = @

  # Publics
  show: ->
    @el.addClass "active"
    @article.addClass "show"
    @trigger "show"

  hide: ->
    @article.removeClass("show").addClass("hide")
    @trigger "hide"

  # Privates
  onAnimationEnd: =>
    if @article.hasClass "hide"
      @el.removeClass "active"
      @article.removeClass "hide"
