###
Basic fieldset for search

@namespace Atoms.Organism
@class Header, Section, Footer

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.Header extends Atoms.Class.Organism
  @template = """
    <header></header>
  """
  constructor: ->
    super
    @render()


class Atoms.Organism.Section extends Atoms.Class.Organism
  @template = """
    <section {{#if.id}}id="{{id}}"{{/if.id}}></section>
  """
  constructor: ->
    super
    @render()


class Atoms.Organism.Footer extends Atoms.Class.Organism
  @template = """
    <footer></footer>
  """
  constructor: ->
    super
    @render()
