
class Atoms.Organism.Article extends Atoms.Core.Class.Organism

  @template """
    <article {{#if.id}}id="{{id}}"{{/if.id}}></article>"""

  areas: ["header", "section", "footer"]

