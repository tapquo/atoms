
# Globals
Atoms = @Atoms =
  version   : "0.0.5"
  Core      : Class: {}
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  System    : {}
  # DOM Handler Facade
  $: (args...) -> if $$? then $$ args... else $ args...
