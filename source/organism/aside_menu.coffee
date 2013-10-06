###
@TODO

@namespace Atoms.Organism
@class AsideMenu

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.AsideMenu extends Atoms.Class.Organism

  template: """<aside class="{{style}}">
    <header>{{text}}</header>
    <article></article>
  </aside>"""

  molecules:
    navigation:
      link: [
        href: "http://google.com", label: "Google", icon: "google"
      ,
        href: "http://tapquo.com", label: "tapquo"
      ,
        href: "http://w3c.com", label: "w3c", icon: "html5"]

  bindings:
    navigation: ["select"]

  constructor: ->
    # @el = Atoms.$(Atoms.Core.render(@template)(attributes)).children("article")
    super

  navigationSelect: (event, molecule) ->
    console.log "navigationSelect", event, molecule
