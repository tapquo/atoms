
class Atoms.Organism.Aside extends Atoms.Core.Class.Organism

  @template """<aside class="active"></aside>"""

  areas: ["header", "section"]

  constructor: (@attributes)->
    attributes.method = "prepend"
    super
