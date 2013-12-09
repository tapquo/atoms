describe "Atom", ->

  template = "<input type='{{type}}' />"
  el       = undefined
  Input    = undefined

  beforeEach ->
    class Input extends Atoms.Class.Atom
      @template = template
      events: ["click"]

    el = Atoms.$("<div/>").first()


  it "can create a new Atom extends Base", ->
    class Button extends Atoms.Class.Atom
    expect(Button).toBeTruthy()

  it "a instance of Atom needs a template and a parent", ->
    no_template = -> new do class NoTemplate extends Atoms.Class.Atom
    expect(no_template).toThrow()

    no_parent = -> new Input()
    expect(no_parent).toThrow()

  it "can create a instance of Atom", ->
    input = new Input parent: el
    expect(input instanceof Input).toBeTruthy()
    expect(input.el.parent().html()).toEqual el.html()

  it "can set a QuerySelectorAll parent", ->
    input = new Input parent: query = "<header></header>"
    expect(input.el.parent()[0].nodeType).toEqual Atoms.$(query)[0].nodeType

  it "can set attributes in a new Instance of Atom", ->
    input = new Input parent: el, type: "text"
    expect(input.el[0].outerHTML).toEqual '<input type="text" data-atom="input">'

  it "can set a different method to render a instance of Atom in parent", ->
    input = new Input parent: el, type: "text", method: "prepend"
    expect(input.el[0].outerHTML).toEqual '<input type="text" data-atom="input">'

  it "can extend a atom", ->
    class InputBig extends Input
      @template = "<input type='{{type}}' class='big'/>"

    input = new Input parent: el
    inputBig = new InputBig parent: el
    expect(inputBig.constructor.__super__.constructor.name).toEqual input.constructor.name

  it "should bind to a assigned events", ->
    input = new Input parent: el
    expect("click" in input.events).toBeTruthy()
    expect("tap" in input.events).not.toBeTruthy()
