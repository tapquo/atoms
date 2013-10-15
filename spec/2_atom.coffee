describe "Atom", ->

  template = "<input type='{{type}}' />"
  el       = undefined
  Input    = undefined

  beforeEach ->
    class Input extends Atoms.Core.Class.Atom
      template: template
      events: ["click"]

    el = Atoms.$ "<div></div>"


  it "can create a new Atom extends Base", ->
    class Button extends Atoms.Core.Class.Atom
      template: "<button></button>"
    expect(Button).toBeTruthy()

  it "a instance of Atom needs a template and a parent", ->
    no_template = ->
      class NoTemplate extends Atoms.Core.Class.Atom
      new NoTemplate()
    expect(no_template).toThrow()

    no_parent = -> new Input()
    expect(no_parent).toThrow()

  it "can create a instance of Atom", ->
    input = new Input parent: el
    expect(input instanceof Input).toBeTruthy()
    expect(input.parent).toEqual el
    expect(input.el.parent().html()).toEqual el.html()

  it "can set a QuerySelectorAll parent", ->
    input = new Input parent: query = "<header></header>"
    expect(input.parent[0].nodeType).toEqual Atoms.$(query)[0].nodeType

  it "can set attributes in a new Instance of Atom", ->
    input = new Input parent: el, type: "text"
    expect(input.el[0].outerHTML).toEqual '<input type="text">'

  it "can set a different method to render a instance of Atom in parent", ->
    input = new Input parent: el, type: "text", method: "prepend"
    expect(input.el[0].outerHTML).toEqual '<input type="text">'

  it "should bind to a assigned events", ->
    input = new Input parent: el
    expect("click" in input.events).toBeTruthy()
    expect("tap" in input.events).not.toBeTruthy()
