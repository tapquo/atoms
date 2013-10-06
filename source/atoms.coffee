
# Globals
Atoms = @Atoms =
  version   : "0.0.3"
  Class     : {}
  Core      : {}
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  # Core helpers
  className : (string) -> string.charAt(0).toUpperCase() + string.slice(1)
  isArray: (value) -> return {}.toString.call(value) is '[object Array]'
  $: (args...) -> if $$? then $$ args... else $ args...
