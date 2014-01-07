describe "Entity", ->
  Asset = undefined
  pdf = undefined

  beforeEach ->
    class Instance extends Atoms.Class.Entity
    Asset = Instance.fields ["name"]
    pdf = Asset.create name: "test.pdf"

  it "can create records", ->
    expect(Asset.all()[0]).toEqual pdf


  it "can update records", ->
    expect(Asset.all()[0].name).toEqual "test.pdf"
    pdf.name = "wem.pdf"
    pdf.save()
    expect(Asset.all()[0].name).toEqual "wem.pdf"


  it "can destroy records", ->
    pdf.destroy()
    expect(Asset.all()[0]).toBeFalsy()


  it "can find records", ->
    expect(Asset.find(pdf.uid)).toBeTruthy()
    pdf.destroy()
    expect(->
      Asset.find pdf.uid
    ).toThrow()


  it "can find records by attribute", ->
    asset = Asset.findBy "name", "test.pdf"
    expect(asset).toEqual pdf
    asset.destroy()
    expect(Asset.count()).toEqual 0


  it "can check existence", ->
    expect(pdf.exists()).toBeTruthy()
    expect(Asset.exists(pdf.uid)).toBeTruthy()
    pdf.destroy()
    expect(pdf.exists()).toBeFalsy()
    expect(Asset.exists(pdf.uid)).toBeFalsy()


  it "can select records", ->
    asset = Asset.create name: "foo.pdf"
    selected = Asset.select((asset) ->
      asset.name is "foo.pdf"
    )
    expect(selected).toEqual [asset]


  it "can return all records", ->
    asset = Asset.create name: "foo.pdf"
    expect(Asset.all()).toEqual [pdf, asset]


  it "can destroy all records", ->
    Asset.create name: "foo.pdf"
    expect(Asset.count()).toEqual 2
    Asset.destroyAll()
    expect(Asset.count()).toEqual 0


  it "can be serialized into JSON", ->
    expect(JSON.stringify(pdf.attributes())).toEqual "{\"name\":\"test.pdf\"}"


  it "can validate", ->
    Asset.include
      validate: ->
        "Name required"  unless @name
    expect(Asset.create()).toBeFalsy()
    expect(Asset.create(name: "foo.pdf")).toBeTruthy()


  it "has attribute hash", ->
    expect(pdf.attributes()).toEqual name: "test.pdf"


  it "attributes() should not return undefined attributes", ->
    asset = new Asset()
    expect(asset.attributes()).toEqual {}


  it "can load attributes()", ->
    asset = new Asset()
    result = asset.load name: "In da' house"
    expect(result).toBe asset
    expect(asset.name).toEqual "In da' house"
