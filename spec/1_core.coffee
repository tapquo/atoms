describe "Core", ->

  Atom = undefined

  beforeEach ->
    Atom = Atoms.Core.Module

  it "is healthy", ->
    expect(Atoms).toBeTruthy()

  it "Atom exists", ->
    expect(Atoms.Core.Class.Atom).toBeTruthy()

  it "Molecule exists", ->
    expect(Atoms.Core.Class.Molecule).toBeTruthy()

  it "Organism exists", ->
    expect(Atoms.Core.Class.Organism).toBeTruthy()

  it "Template exists", ->
    expect(Atoms.Core.Class.Organism).toBeTruthy()

  it "can create subclasses", ->
    Atom.extend classProperty: true
    chemistry = Atom.create()
    expect(chemistry).toBeTruthy()
    expect(chemistry.classProperty).toBeTruthy()

  it "can be extendable", ->
    Atom.extend classProperty: true
    expect(Atom.classProperty).toBeTruthy()

  it "can be includable", ->
    Atom.include instanceProperty: true
    expect(Atom::instanceProperty).toBeTruthy()
    expect((new Atom()).instanceProperty).toBeTruthy()

  it "should trigger module callbacks", ->
    module =
      included: ->
      extended: ->
    spyOn module, "included"
    Atom.include module
    expect(module.included).toHaveBeenCalled()
    spyOn module, "extended"
    Atom.extend module
    expect(module.extended).toHaveBeenCalled()

  it "include/extend should raise without arguments", ->
    expect(-> Atom.include() ).toThrow()
    expect(-> Atom.extend() ).toThrow()
