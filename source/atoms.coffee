
# Globals
Atoms = @Atoms =
  version   : "0.0.1"
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  $         : (args...) -> if $$? then $$ args... else $ args...
