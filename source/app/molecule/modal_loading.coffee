###
Base class for Organism

@namespace Atoms.Organism
@class Loading

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Molecule.Loading extends Atoms.Molecule.Modal

  @template = """
    <div data-component="modal" class="loading">
      <article></article>
    </div>"""

new Atoms.Molecule.Loading()
