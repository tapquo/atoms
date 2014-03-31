###
Constants

@namespace Atoms.Core
@class Constants

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Constants =

  ANIMATION:
    END   : "webkitAnimationEnd mozAnimationEnd animationend"

  APPEND:  "append"

  EXCLUDED_IF_KEYS: ["class", "entity", "events", "if", "parent", "children"]

  ENTITY:
    EVENT:
      CREATE  : "create"
      UPDATE  : "update"
      DESTROY : "destroy"
