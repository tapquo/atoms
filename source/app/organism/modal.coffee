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

  constructor: ->
    yaml = null
    super
