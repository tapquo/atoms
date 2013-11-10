###
Basic fieldset for search

@namespace Atoms.Organism
@class Header, Section, Footer

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.Header extends Atoms.Core.Class.Organism
  @template """
    <header></header>
  """


class Atoms.Organism.Section extends Atoms.Core.Class.Organism
  @template """
    <section {{#if.id}}id="{{id}}"{{/if.id}}></section>
  """


class Atoms.Organism.Footer extends Atoms.Core.Class.Organism
  @template """
    <footer></footer>
  """

