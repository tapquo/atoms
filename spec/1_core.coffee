describe "Core", ->

  Atom        = undefined
  atomEmitter = undefined
  spy         = undefined

  beforeEach ->
    Atom = Atoms.Core.Module

    atomEmitter = Atom.create()
    atomEmitter.extend Atoms.Core.Event
    noop = spy: ->
    spyOn noop, "spy"
    spy = noop.spy


  it "is healthy", ->
    expect(Atoms).toBeTruthy()

  it "Atom class exists", ->
    expect(Atoms.Class.Atom).toBeTruthy()

  it "Molecule class exists", ->
    expect(Atoms.Class.Molecule).toBeTruthy()

  it "Organism class exists", ->
    expect(Atoms.Class.Organism).toBeTruthy()

  it "Template class exists", ->
    expect(Atoms.Class.Organism).toBeTruthy()

  it "can generate UID", ->
    module = new Atoms.Core.Module()
    expect(module.uid).toBeTruthy()

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

  it "can bind/trigger events", ->
    atomEmitter.bind "hello", spy
    atomEmitter.trigger "hello"
    expect(spy).toHaveBeenCalled()

  it "should trigger correct events", ->
    atomEmitter.bind "hello", spy
    atomEmitter.trigger "bye"
    expect(spy).not.toHaveBeenCalled()

  it "can bind/trigger multiple events", ->
    atomEmitter.bind "hello guy by", spy
    atomEmitter.trigger "guy"
    expect(spy).toHaveBeenCalled()

  it "can pass data to triggered events", ->
    atomEmitter.bind "yoyo", spy
    atomEmitter.trigger "yoyo", 5, 10
    expect(spy).toHaveBeenCalledWith 5, 10, atomEmitter

  it "can unbind events", ->
    atomEmitter.bind "hello", spy
    atomEmitter.unbind "hello"
    atomEmitter.trigger "hello"
    expect(spy).not.toHaveBeenCalled()

  it "can cancel propogation", ->
    #
    atomEmitter.bind "bye", -> false
    atomEmitter.bind "bye", spy
    atomEmitter.trigger "bye"
    expect(spy).not.toHaveBeenCalled()
