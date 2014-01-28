class Atoms.Molecule.ListContacts extends Atoms.Molecule.List

  constructor: (attributes={}) ->
    attributes.class = "LiThumbnail"
    attributes.events = ["touch"]
    super attributes

  liTouch: (event, atom) ->
    console.log "trigger", atom, atom.entity

  bubbleLiTouch: (event, atom) ->
    console.log "bubble", atom, atom.attributes.entity
