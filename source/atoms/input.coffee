class Atoms.Atom.Input extends Atoms.BaseAtom

  template: """
        <input type="{{type}}" id="{{id}}" placeholder="{{placeholder}}" />
    """

  events: ["click", "keypress", "keyup"]
