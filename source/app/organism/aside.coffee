
class Atoms.Organism.Aside extends Atoms.Core.Class.Organism

  @template """<aside class="active"></aside>"""

  constructor: (@attributes)->
    attributes.method = "prepend"
    super
