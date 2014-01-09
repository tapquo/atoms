describe "Organism", ->

  el          = undefined
  Search      = undefined
  spy         = undefined
  Article     = undefined

  attributes  =
    children: [
      "Organism.Header":
        children: [
          "Molecule.Navigation":
            style: "left"
            children: [
              button: icon: "edit"
            ,
              button: icon: "search"
            ]
        ]
    ,
      "Organism.Section":
        children: [
          "Atom.Button": icon: "ok"
        ]
    ]

  beforeEach ->
    noop = spy: ->
    spyOn noop, "spy"
    spy = noop.spy

    class Atoms.Atom.Button extends Atoms.Class.Atom
      @template = "<button>{{text}}</button>"

    class Atoms.Molecule.Navigation extends Atoms.Class.Molecule
      @template = "<nav></nav>"
      available: ["button", "link"]

    class Article extends Atoms.Class.Organism
      @template = "<article/>"

      navigationSelect: spy
      buttonClick: spy

    class Atoms.Organism.Header extends Atoms.Class.Organism
      @template = "<header></header>"

    class Atoms.Organism.Section extends Atoms.Class.Organism
      @template = "<section></section>"

    el = Atoms.$("<div/>").first()
    attributes.parent = el


  it "can create a new Organism extends Base", ->
    class Organism extends Atoms.Class.Organism
    expect(Organism).toBeTruthy()

  it "a instance of Organism needs a template and a parent", ->
    no_template = -> new do class NoTemplate extends Atoms.Class.Organism
    expect(no_template).toThrow()
    no_parent = -> new do Article()
    expect(no_parent).toThrow()

  it "can create a instance of Organism", ->
    article = new Article parent: el
    expect(article instanceof Article).toBeTruthy()

  it "can render a instance of Organism", ->
    article = new Article parent: el
    expect(article.el).toBeFalsy()
    article.render()
    expect(article.el).toBeTruthy()
    expect(article.el.parent().html()).toEqual el.html()

  it "Instance of Organism has areas for Atoms & Molecules", ->
    article = new Article attributes
    article.render()
    expect(article.el.children("header")).toBeTruthy()
    expect(article.Header[0]).toBeTruthy()
    expect(article.el.children("section")).toBeTruthy()
    expect(article.Section[0]).toBeTruthy()
    expect(article.el.children("footer").length > 0).toBeFalsy()
    expect(article.Footer?[0]).toBeFalsy()

  it "Instances of atoms and molecules make up the Organism", ->
    article = new Article attributes
    spyOn article, "_createChildren"
    article.render()
    expect(article.el.children("header")).toBeTruthy()
    expect(article.el.children("header").children("nav")).toBeTruthy()
    # expect(article.navigation.length > 0).toBeTruthy()
    expect(article.el.children("section").children("button")).toBeTruthy()
    # expect(article.button.length > 0).toBeTruthy()

  # it "Organism can bind to defined Atoms & Molecules events", ->
  #   attributes.children[0]["Organism.Header"].children[0]["Molecule.Navigation"].events = ["select"]
  #   article = new Article attributes
  #   article.render()
  #   article.Header[0].Navigation[0].trigger "select"
  #   expect(spy).toHaveBeenCalled()

  # it "Organism can't bind to defined Atoms & Molecules events", ->
  #   article = new Article attributes
  #   article.render()
  #   expect(article.Section[0]).toBeTruthy()
  #   article.Section[0].Button[0].trigger "click"
  #   expect(spy).not.toHaveBeenCalled()
