###
Base class for Organism

@namespace Atoms.Organism
@class Modal

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.Modal extends Atoms.Core.Class.Organism

  @template """
    <div data-component="modal">
      <article>
        <header>
          {{#if.icon}}<span class="icon {{icon}}"></span>{{/if.icon}}
          {{#if.title}}<h1>{{title}}</h1>{{/if.title}}
        </header>
        <section>{{text}}</section>
        <footer>
          <nav>
            <button>Yes</button>
            <button>No</button>
          </nav>
        <footer>
      </article>
    </div>"""

  areas: ["header", "section", "footer"]

  constructor: (@attributes={}) ->
    @constructor.type = "Modal"
    @attributes.parent = document.body
    super @attributes
    @render()

    @article = @el.children("article")
    # @TODO: Test in QuoJS
    @article.bind "webkitAnimationEnd mozAnimationEnd", @onAnimationEnd
    @article.find("button").bind "click", => @hide()
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
