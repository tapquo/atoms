class Atoms.BaseOrganism extends Atoms.Module

  @include Atoms.EventEmitter

  system    : null
  molecules : {}
  template  : ""

  constructor: (@attributes) ->
    super
    @type = "Organism"

    @el = Atoms.$ Atoms.render(@template)(@attributes)
    if @attributes?.system?
      @system = Atoms.$ @attributes.system
      @system.append @el

    @createMolecules()
    @


  createMolecules: ->
    for index of @molecules
      molecule = @molecules[index]
      className = index[0].toUpperCase() + index[1..-1].toLowerCase()


      attributes = @attributes.molecule?[index] or molecule
      attributes.organism = @el

      @[index] = new Atoms.Molecule[className] attributes

      for event in molecule.binds
        console.log  "molecule-#{event}"
        @[index].bind "molecule-#{event}", @[event]
