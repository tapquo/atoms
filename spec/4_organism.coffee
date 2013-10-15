describe "Organism", ->

  el          = undefined
  Search      = undefined
  spy         = undefined
  Article     = undefined
  attributes  =
    header:
        molecule:
          navigation:
            style: "left"
            button: [
              icon: "edit"
            ,
              icon: "search"
            ]
      section:
        atom:
          button: icon: "ok"

  beforeEach ->
    noop = spy: ->
    spyOn noop, "spy"
    spy = noop.spy

    class Article extends Atoms.Core.Class.Organism
      template: "<article/>"
      areas: ["header", "section", "footer"]

      navigationSelect: spy
      buttonClick: spy

    el = Atoms.$ "<div/>"
    attributes.parent = el


  it "can create a new Organism extends Base", ->
    class Organism extends Atoms.Core.Class.Organism
      template: "<article/>"
      areas: ["header"]
    expect(Organism).toBeTruthy()

  it "a instance of Atom needs a template and a parent", ->
    no_template = ->
      class NoTemplate extends Atoms.Core.Class.Organism
      new NoTemplate()
    expect(no_template).toThrow()

    no_parent = -> new Article()
    expect(no_parent).toThrow()

  it "can create a instance of Molecule", ->
    article = new Article parent: el
    expect(article instanceof Article).toBeTruthy()
    expect(article.parent).toEqual el
    expect(article.el.parent().html()).toEqual el.html()

  it "Instance of Organism has areas for Atoms & Molecules", ->
    attributes.div = []
    article = new Article attributes
    expect(article.el.children("header").length > 0).toBeTruthy()
    expect(article.el.children("div").length > 0).not.toBeTruthy()
    expect(article.el.children("footer").length > 0).not.toBeTruthy()

  it "Instances of atoms and molecules make up the Organism", ->
    article = new Article attributes
    expect(article.el.children("header").children("nav").length > 0).toBeTruthy()
    expect(article.navigation.length > 0).toBeTruthy()
    expect(article.el.children("section").children("button").length > 0).toBeTruthy()
    expect(article.button.length > 0).toBeTruthy()

  it "Organism can bind to defined Atoms & Molecules events", ->
    attributes.bindings = header: navigation: ["select"]
    article = new Article attributes
    article.navigation[0].trigger "select"
    expect(spy).toHaveBeenCalled()

  it "Organism can't bind to defined Atoms & Molecules events", ->
    article = new Article attributes
    article.button[0].trigger "click"
    expect(spy).not.toHaveBeenCalled()
