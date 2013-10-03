class Atoms.Atom.Button extends Atoms.BaseAtom

  template: """
    <atom-button>
        <button id="{{id}}">
        {{label}}
        </button>
    </atom-button>"""

  events: ["click"]
