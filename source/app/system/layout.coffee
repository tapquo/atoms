###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.System.Layout = do(a = Atoms) ->

  _show = (article, organism) ->
    a.System.Cache[article].el.addClass "active"

    # window.history.pushState {}, "Atoms #{article}", "#{article}"
    # setTimeout ->
    #   window.history.back()
    # , 1000


  _back = (article, section) ->
    console.log "back"

  show: _show
  back: _back
