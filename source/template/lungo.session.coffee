
class Atoms.Template.LungoSession extends Atoms.Core.Class.Template

  template: """
    <article id="{{id}}" atom-template="LoginSignup">
      <section>
        {{#if.logo}}<img src="{{logo}}" />{{/if.logo}}
        {{#if.title}}<h1>{{title}}</h1>{{/if.title}}
        <small>{{copyright}}</small>
      </section>
    </article>"""

  ifs: ["logo", "title"]

  inputs: [
    type        : "text"
    name        : "user"
    placeholder : "Type your username"
    required    : true
  ,
    type        : "password"
    name        : "password"
    placeholder : "Type your password.."
    required    : true
  ]

  buttons: [
    icon: "user", text: "Login", style: "accept"
  ,
    icon: "signin", text: "Signup"
  ]

  constructor: (@attributes) ->
    for input, index in @attributes.inputs
      @inputs[index] = Atoms.Core.Helper.mix(input, @inputs[index])
    super
    section = @el.children("section")

    @form = new Atoms.Molecule.Form parent: section, input: @inputs
    @form.bind "keyup", @formKeyup

    @navigation = new Atoms.Molecule.Navigation parent: section, button: @buttons
    @navigation.bind "select", @navigationSelect

    @formKeyup()


  navigationSelect: (event) =>
    is_valid = true
    properties = {}
    for input in @form.input
      el = input.el
      properties[el.attr "name"] = el.val()
      is_valid = false if el.attr("required")? and el.val() is ""
    properties
    if is_valid then @trigger "validate", properties


  formKeyup: (event) =>
    is_valid = @_readProperties()

    for button in @navigation.button
      if is_valid
        button.el.removeAttr "disabled"
      else
        button.el.attr "disabled", "disabled"

  _readProperties: ->
    is_valid = true
    for input in @form.input
      el = input.el
      is_valid = false if el.attr("required")? and el.val() is ""
    is_valid

