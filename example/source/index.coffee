Atoms.$ ->

  console.log "------------------------------------------------------------"
  console.log "Atoms #{Atoms.version}", Atoms
  console.log "------------------------------------------------------------"

  if navigator.standalone
    $(document.body).addClass "standalone"

  # ------------------------------------------------------------
  # URL
  # ------------------------------------------------------------
  # Atoms.Url.path "first", "form"
  # Atoms.Url.path "second", "main"
  # Atoms.Url.path "third", "second"
