# Globals
Atoms = @Atoms =
  version   : "0.06.09"
  Core      : {}
  Class     : {}

  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Entity    : {}
  # DOM Handler Facade
  $: (args...) -> if $$? then $$ args... else $ args...
