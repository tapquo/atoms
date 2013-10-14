$ ->
  # session = new Atoms.Template.LungoSession
  #   parent: document.body
  #   title: "Atoms App"
  #   logo: "http://cdn.tapquo.com/photos/soyjavi.jpg"
  #   copyright: "Tapquo S.L. 2013"
  #   inputs: [
  #     placeholder: "Your name..."
  #   ,
  #     placeholder: "Your password..."
  #   ]

  class First extends Atoms.Organism.LungoArticle
    navigationSelect: (event, atom, molecule) ->
      console.log "event", event
      console.log "atom", atom
      console.log "molecule", molecule

    formKeyup: (keycode, atom, molecule) ->
      console.log keycode, atom, molecule

    formClick: (event, atom) ->
      console.log event, atom

  YAML.load 'organisms/first.yml', (attributes) ->
    attributes.parent = document.body
    org = new First attributes


