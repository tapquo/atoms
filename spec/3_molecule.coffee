describe "Molecule", ->

  el      = undefined
  Search  = undefined
  spy     = undefined

  beforeEach ->

    noop = spy: ->
    spyOn noop, "spy"
    spy = noop.spy

    class Atoms.Atom.Button extends Atoms.Core.Class.Atom
      @template "<button>{{text}}</button>"

    class Atoms.Atom.Input extends Atoms.Core.Class.Atom
      @template "<input type='{{type}}' />"

    class Search extends Atoms.Core.Class.Molecule

      @template "<fieldset/>"

      available: ["input", "button"]

      constructor: ->
        @default =
          children: [
            input: type: "search", placeholder: "Type your search..."
          ,
            button: text: "Go!"
          ]
          events:
            input: ["keyup"]
            button: ["click"]
        super

      buttonClick: spy

      buttonDblClick: spy

    el = Atoms.$("<div/>").first()


  it "can create a new Molecule extends Base", ->
    class Search extends Atoms.Core.Class.Molecule
    expect(Search).toBeTruthy()

  it "a instance of Molecule needs a template and a parent", ->
    no_template = -> new do class NoTemplate extends Atoms.Core.Class.Molecule
    expect(no_template).toThrow()
    no_parent = -> new Article()
    expect(no_parent).toThrow()

  it "can create a instance of Molecule", ->
    search = new Search parent: el
    expect(search instanceof Search).toBeTruthy()
    expect(search.el.parent().html()).toEqual el.html()

  it "Instances of Atoms make up the Molecule", ->
    search = new Search parent: el
    expect(search.el.children("input")).toBeTruthy()
    expect(search.input.length > 0).toBeTruthy()
    expect(search.el.children("button")).toBeTruthy()
    expect(search.button.length > 0).toBeTruthy()

  it "Molecule can bind to defined Atoms events", ->
    search = new Search parent: el
    search.button[0].trigger "click"
    expect(spy).toHaveBeenCalled()

  it "Molecule can't bind to undefined Atoms events", ->
    search = new Search parent: el
    search.button[0].trigger "dblClick"
    expect(spy).not.toHaveBeenCalled()
