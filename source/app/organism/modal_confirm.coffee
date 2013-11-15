###
Base class for Organism

@namespace Atoms.Organism
@class Confirm

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.Confirm extends Atoms.Organism.Modal

  @template = """
    <div data-component="modal" class="confirm">
      <article>
        <header>
          {{#if.icon}}<span class="icon {{icon}}"></span>{{/if.icon}}
          {{#if.title}}<h1>{{title}}</h1>{{/if.title}}
        </header>
        <section>{{text}}</section>
        <footer>
          <nav>
            <button class="accept">{{accept}}</button>
            <button class="cancel">{{cancel}}</button>
          </nav>
        <footer>
      </article>
    </div>"""

  constructor: ->
    super
    @article.find("button").bind "click", @buttonClick

  buttonClick: (event) =>
    @trigger Atoms.$(event.target).attr "class"
    @hide()
