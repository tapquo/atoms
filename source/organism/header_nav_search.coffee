###
@TODO

@namespace Atoms.Organism
@class HeaderNavSearch

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.HeaderNavSearch extends Atoms.Class.Organism

  template: """<header></header>"""

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

    # navigation:
    #   style: "on_left"
    #   button: [
    #     label: "Google", icon: "google"
    #   ,
    #     label: "tapquo"]

  bindings:
    search: ["on", "off"]
    navigation: ["select"]

  navigationSelect: (event, molecule) ->
    console.log "navigationSelect", event, molecule

  searchOn: (event, molecule) ->
    console.log "searchOn", event, molecule

  searchOff: (event, molecule) ->
    console.log "searchOff", event, molecule
