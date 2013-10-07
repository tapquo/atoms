###
@TODO

@namespace Atoms.Organism
@class HeaderNavSearch

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.HeaderNavSearch extends Atoms.Class.Organism

  template: """<header organism-class="{{className}}"></header>"""

  molecules:
    search: style: "none"
    navigation:
      style: "on_right"
      link: [
        href: "http://google.com", label: "Google", icon: "google"
      ,
        href: "http://tapquo.com", label: "tapquo"
      ,
        href: "http://w3c.com", label: "w3c", icon: "html5"]
      button: [
        label: "Google", icon: "google"]

  bindings:
    search: ["enter"]
    navigation: ["select"]

  navigationSelect: (event, molecule) ->
    console.log "navigationSelect", event, molecule

  searchEnter: (value, molecule) ->
    console.log "searchEnter", value, molecule
