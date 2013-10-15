describe "Organism", ->

  el          = undefined
  Search      = undefined
  spy         = undefined
  Template    = undefined

  beforeEach ->
    noop = spy: ->
    spyOn noop, "spy"
    spy = noop.spy

    class Template extends Atoms.Core.Class.Template
      template: "<article><h1>{{title}}</h1></article>"
      title: "Hi Atoms!!!"

    el = Atoms.$ "<div/>"


  it "can create a new Template extends Base", ->
    class Template extends Atoms.Core.Class.Template
    expect(Template).toBeTruthy()

  it "a instance of Template needs a template and a parent", ->
    no_template = -> new do class NoTemplate extends Atoms.Core.Class.Template
    expect(no_template).toThrow()
    no_parent = -> new Template()
    expect(no_parent).toThrow()

  it "can create a instance of Template", ->
    template = new Template parent: el
    expect(template instanceof Template).toBeTruthy()
    expect(template.parent).toEqual el
    expect(template.el.parent().html()).toEqual el.html()

  it "Templates are shielded only be assigned attributes that exist in the base", ->
    template = new Template parent: el


