# Globals
Atoms = @Atoms =
  version   : "0.11.13"
  Core      : Class: {}
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  App       :
    Article : {}
    Modal   : {}
    Section : {}
    Template: {}
  # DOM Handler Facade
  $: (args...) -> if $$? then $$ args... else $ args...
