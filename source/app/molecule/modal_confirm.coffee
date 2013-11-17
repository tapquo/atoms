###
Base class for Organism

@namespace Atoms.Organism
@class Confirm

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Confirm extends Atoms.Molecule.Modal

  @template = """
    <div data-component="modal" class="confirm">
      <article>
        <header>
          {{#if.icon}}<span class="icon {{icon}}"></span>{{/if.icon}}
          {{#if.title}}<h1>{{title}}</h1>{{/if.title}}
        </header>
        <section>{{text}}</section>
        <footer></footer>
      </article>
    </div>"""

  constructor: ->
    super
    navigation = new Atoms.Molecule.Navigation
      parent: @article.children("footer")
      events: ["select"]
      children: [
        button: text: @attributes.accept, action: "accept"
      ,
        button: text: @attributes.cancel, action: "cancel"
      ]
    navigation.bind "select", @navigationSelect

  navigationSelect: (event, atom) =>
    @trigger atom.action
    @hide()
