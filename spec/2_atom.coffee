describe "Atom", ->

  # Basic elements
  template = "<input type='{{type}}' />"
  type = "text"
  template_binded = "<input type='#{type}' />"
  element = undefined

  class AtomEmpty extends Atoms.Class.Atom
    constructor: -> super

  class AtomTest extends Atoms.Class.Atom
    template: template

  beforeEach ->
    element = Atoms.$ "<div />"


  # Expects
  it "can create a new Base instance", ->
    atom = new Atoms.Class.Atom template: "<li>"
    expect(atom).toBeTruthy()
    expect(atom.append).toBeTruthy()


  it "a Atom need a template", ->
    atom = new AtomEmpty()
    expect(atom).toBeTruthy()
    expect(atom.template).toBe null

    atom = new AtomTest
    expect(atom.template).toBe template

  it "a new Atom can set into a Molecule", ->
    atom = new AtomTest molecule: element, type: type
    atom.html()
    expect(atom.el.parent()[0]).toBe element[0]

  it "a new Atom can set attributes for binding in template", ->
    atom = new AtomTest molecule: element, type: type
    atom.html()
    expect(atom.el.html()).toBe template_binded

  # it "should allow a callback unbind itself", ->
  #   a = jasmine.createSpy("a")
  #   b = jasmine.createSpy("b")
  #   c = jasmine.createSpy("c")
  #   b.andCallFake ->
  #     EventTest.unbind "once", b

  #   EventTest.bind "once", a
  #   EventTest.bind "once", b
  #   EventTest.bind "once", c
  #   EventTest.trigger "once"
  #   expect(a).toHaveBeenCalled()
  #   expect(b).toHaveBeenCalled()
  #   expect(c).toHaveBeenCalled()
  #   EventTest.trigger "once"
  #   expect(a.callCount).toBe 2
  #   expect(b.callCount).toBe 1
  #   expect(c.callCount).toBe 2
