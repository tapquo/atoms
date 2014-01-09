describe "Template", ->

  el          = undefined
  Template    = undefined

  beforeEach ->

    class Template extends Atoms.Class.Template
      @attributes "title", "button"
      @template = "<article><h1>{{title}}</h1></article>"
      title: "Hi Atoms!!!"
      button:
        icon: "profile"

    el = Atoms.$("<div/>").first()


  it "can create a new Template extends Base", ->
    class Template extends Atoms.Class.Template
    expect(Template).toBeTruthy()

  it "a instance of Template needs a template and a parent", ->
    no_template = -> new do class NoTemplate extends Atoms.Class.Template
    expect(no_template).toThrow()
    no_parent = -> new Template()
    expect(no_parent).toThrow()

  it "can create a instance of Template", ->
    template = new Template parent: el
    expect(template instanceof Template).toBeTruthy()

  # it "Templates are shielded only be assigned attributes that exist in the base", ->
  #   template = new Template parent: el
  #   expect(template.constructor.elements).toEqual ["title", "button"]
