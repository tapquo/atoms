class Atoms.Atom.Input extends Atoms.BaseAtom

  template: """
    <atom-input>
        <input type="{{type}}" id="{{id}}" placeholder="{{placeholder}}" />
    </atom-input>"""

  events: ["click", "keypress", "keyup"]

  keyup: (event) ->
    console.log "keyup", event.keyCode

  click: (event) ->
    console.log "click", event

  keypress: (event) ->
    console.log "keypress", event.keyCode
