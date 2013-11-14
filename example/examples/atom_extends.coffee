
class ButtonBig extends Atoms.Atom.Button

  constructor: ->
    @constructor.template = "<button class='big'><span class='icon profile'></span>{{text}}</button>"
    super
