
class Atoms.Template.Session extends Atoms.Core.Class.Template

  # Template
  # ---------------------------------------------------------------------------
  @attributes "title", "logo", "inputs", "buttons", "copyright"

  @template """
    <article id="session" atom-template="LoginSignup">
      <section>
        {{#if.logo}}<img src="{{logo}}" />{{/if.logo}}
        {{#if.title}}<h1>{{title}}</h1>{{/if.title}}
        <small>{{copyright}}</small>
      </section>
    </article>"""


  # Attributes
  # ---------------------------------------------------------------------------
  logo      : undefined
  title     : "Your app title..."
  copyright : "Your company copyright..."
  inputs:   [
    type        : "text"
    name        : "user"
    placeholder : "Type your username"
    required    : true
  ,
    type        : "password"
    name        : "password"
    placeholder : "Type your password.."
    required    : true]
  buttons:  [
    icon: "user", text: "Login", style: "accept"
  ,
    icon: "signin", text: "Signup"]

  # Template Business
  # ---------------------------------------------------------------------------
  constructor: (@attributes) ->
    super
    section = @el.children("section")

    @form = new Atoms.Molecule.Form parent: section, input: @inputs
    @form.bind "keyup", @formKeyup

    @navigation = new Atoms.Molecule.Navigation parent: section, button: @buttons
    @navigation.bind "select", @navigationSelect

    @formKeyup()

  navigationSelect: (event) =>
    if @_filledRequiredFields()
      @trigger "validate", @form.parse()

  formKeyup: (event) =>
    is_valid = @_filledRequiredFields()
    for button in @navigation.button
      if is_valid
        button.el.removeAttr "disabled"
      else
        button.el.attr "disabled", "disabled"

  _filledRequiredFields: ->
    is_valid = true
    for input in @form.input
      el = input.el
      is_valid = false if el.attr("required")? and el.val() is ""
    is_valid
