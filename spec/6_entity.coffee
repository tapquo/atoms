describe "Entity", ->
  Asset = undefined

  beforeEach ->
    class Instance extends Atoms.Class.Entity
    Asset = Instance.fields(["name"])

  it "can create records", ->
    asset = Asset.create name: "test.pdf"
    expect(Asset.all()[0]).toEqual asset
