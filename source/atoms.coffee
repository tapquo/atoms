
# Globals
Atoms = @Atoms =
  version   : "0.0.4"
  Core      :
    Class: {}
    className : (string) -> string.charAt(0).toUpperCase() + string.slice(1)
    isArray   : (value) -> return {}.toString.call(value) is '[object Array]'
  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Template  : {}
  System    : {}
  # DOM Handler Facade
  $: (args...) -> if $$? then $$ args... else $ args...
