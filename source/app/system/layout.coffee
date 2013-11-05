###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.System.Layout = do(a = Atoms) ->

  current = null

  _show = (article, organism) ->
    article = a.System.Cache[article]
    article.state("in")

    if @current then @current.state("back-in")

    @current = article

    # window.history.pushState {}, "Atoms #{article}", "#{article}"
    # setTimeout ->
    #   window.history.back()
    # , 1000


  _back = ->
    @current.state("out")
    @current = a.System.Cache.First
    @current.state("back-out")

  show: _show
  return: _back
