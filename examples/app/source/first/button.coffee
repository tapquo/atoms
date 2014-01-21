class Atoms.Atom.Button2 extends Atoms.Atom.Button

  event_form_va: (event, args...) =>
    @el.toggleClass "accept"
