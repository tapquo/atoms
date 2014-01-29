class Atoms.Molecule.ListContacts extends Atoms.Molecule.List

  constructor: ->
    @default =
      children:
        Li: events: ["touch", "swipeLeft"]
    super

  bubbleLiTouch: (event, atom) ->
    console.log "bubble", atom, atom.attributes.entity
    atom.entity.updateAttributes text: "Hello", description: "UPDATED!",

  bubbleLiSwipeLeft: (event, atom) ->
    atom.entity.destroy()
