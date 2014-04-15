describe "Molecule", ->

  el      = undefined
  Search  = undefined
  spy     = undefined

  beforeEach ->

    noop = spy: ->
    spyOn noop, "spy"
    spy = noop.spy

    class Atoms.Atom.Button extends Atoms.Class.Atom
      @template = "<button>{{text}}</button>"

    class Atoms.Atom.Input extends Atoms.Class.Atom
      @template = "<input type='{{type}}' />"

    class Search extends Atoms.Class.Molecule
      @template : "<fieldset/>"

      @available: ["Atom.Input", "Atom.Button"]

      @default  :
        children: [
          "Atom.Input": id: "input", type: "search", placeholder: "Type your search...", events: ["keyup"]
        ,
          "Atom.Button": id: "button", text: "Go!", events: ["click"]
        ]

      onButtonClick: spy

      onButtonDblclick: spy

    el = Atoms.$("<div/>").first()


  it "can create a new Molecule extends Base", ->
    class Search extends Atoms.Class.Molecule
    expect(Search).toBeTruthy()

  it "a instance of Molecule needs a template and a parent", ->
    no_template = -> new do class NoTemplate extends Atoms.Class.Molecule
    expect(no_template).toThrow()
    no_parent = -> new Article()
    expect(no_parent).toThrow()

  it "can create a instance of Molecule", ->
    search = new Search parent: el: el
    expect(search instanceof Search).toBeTruthy()
    expect(search.el.parent().html()).toEqual el.html()

  it "Instances of Atoms make up the Molecule", ->
    search = new Search parent: el: el
    expect(search.el.children("input")).toBeTruthy()
    expect(search.input).toBeTruthy()

  it "can subscribe to children bubble events", ->
    search = new Search parent: el: el
    search.button.el.trigger "click"
    expect(spy).toHaveBeenCalled()

  it "can't subscribe to children bubble events", ->
    search = new Search parent: el: el
    search.button.el.trigger "dblClick"
    expect(spy).not.toHaveBeenCalled()

  it "can add a new children with AppenChild method", ->
    search = new Search parent: el: el
    expect(search.children.length).toEqual(2)
    search.appendChild "Atom.Button", id: "btnCancel", text: "Cancel"
    expect(search.children.length).toEqual(3)
    expect(search.btnCancel).toBeTruthy()
    expect(search.btnCancel.el).toBeTruthy()
    expect(search.btnCancel.attributes.text).toEqual("Cancel")
