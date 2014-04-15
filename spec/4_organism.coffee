describe "Organism", ->

  el          = undefined
  Search      = undefined
  spy         = undefined
  Article     = undefined

  attributes  =
    children: [
      "Organism.Header":
        id: "header"
        events: ["load"]
        children: [
          "Molecule.Navigation":
            id: "menu"
            style: "left"
            events: ["select"]
            children: [
              "Atom.Button": icon: "edit"
            ,
              "Atom.Button": icon: "search"
            ]
        ]
    ,
      "Organism.Section":
        id: "section"
        children: [
          "Atom.Button": id: "button", icon: "ok"
        ]
    ]

  beforeEach ->
    noop = spy: ->
    spyOn noop, "spy"
    spy = noop.spy

    class Atoms.Atom.Button extends Atoms.Class.Atom
      @template : "<button>{{text}}</button>"

    class Atoms.Molecule.Navigation extends Atoms.Class.Molecule
      @template : "<nav></nav>"
      available: ["button", "link"]

    class Article extends Atoms.Class.Organism
      @template : "<article/>"

      onNavigationSelect: -> do spy

    class Atoms.Organism.Header extends Atoms.Class.Organism
      @template : "<header></header>"

    class Atoms.Organism.Section extends Atoms.Class.Organism
      @template : "<section></section>"

    class Atoms.Organism.Footer extends Atoms.Class.Organism
      @template : "<footer></footer>"

    el = Atoms.$("<div/>").first()
    attributes.el = el


  it "can create a new Organism extends Base", ->
    class Organism extends Atoms.Class.Organism
    expect(Organism).toBeTruthy()

  it "a instance of Organism needs a template and a parent", ->
    no_template = -> new do class NoTemplate extends Atoms.Class.Organism
    expect(no_template).toThrow()
    no_parent = -> new do Article()
    expect(no_parent).toThrow()

  it "can create a instance of Organism", ->
    article = new Article parent: el: el
    expect(article instanceof Article).toBeTruthy()

  it "can render a instance of Organism", ->
    article = new Article parent: el: el
    expect(article.el).toBeFalsy()
    article.render()
    expect(article.el).toBeTruthy()
    expect(article.el.parent().html()).toEqual el.html()

  it "Instance of Organism has areas for Atoms & Molecules", ->
    article = new Article attributes
    article.render()
    expect(article.el.children("header")).toBeTruthy()
    expect(article.header).toBeTruthy()
    expect(article.el.children("section")).toBeTruthy()
    expect(article.section).toBeTruthy()
    expect(article.el.children("footer").length > 0).toBeFalsy()
    expect(article.footer).toBeFalsy()

  it "Instances of atoms and molecules make up the Organism", ->
    article = new Article attributes
    article.render()
    expect(article.el.children("header").children("nav")).toBeTruthy()
    expect(article.el.children("section").children("button")).toBeTruthy()

  it "can subscribe to children bubble events", ->
    article = new Article attributes
    article.render()
    expect(article.header).toBeTruthy()
    article.header.render()
    article.header.menu.bubble "select", true
    expect(spy).toHaveBeenCalled()

  it "Organism can't to subscribe children bubble events", ->
    article = new Article attributes
    article.render()
    expect(article.section).toBeTruthy()
    article.section.render()
    article.section.button.trigger "click"
    expect(spy).not.toHaveBeenCalled()

  it "can add a new children with AppendChild method", ->
    article = new Article attributes
    article.render()
    expect(article.children.length).toEqual(2)
    article.appendChild "Organism.Footer", id: "footer", info: "footer"
    expect(article.children.length).toEqual(3)
    expect(article.footer).toBeTruthy()
    article.footer.render()
    expect(article.footer.el).toBeTruthy()
    expect(article.footer.attributes.info).toEqual("footer")
