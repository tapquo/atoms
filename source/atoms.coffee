# Globals
Atoms = @Atoms =
  version   : "0.09.03"
  Core      : {}
  Class     : {}

  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Entity    : {}
  # DOM Handler Facade
  $: (args...) -> if $$? then $$ args... else $ args...
