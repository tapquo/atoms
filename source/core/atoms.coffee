# Globals
Atoms = @Atoms =
  version   : "0.0.9"
  Core      : Class: {}
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  System    : Cache : {}
  App       : {}
  # DOM Handler Facade
  $: (args...) -> if $$? then $$ args... else $ args...
