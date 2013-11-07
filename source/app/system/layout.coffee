###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.System.Layout = do (a = Atoms) ->

  current = null

  _show = (article, organism) ->
    article = a.System.Cache[article]
    article.state("in")
    if @current then @current.state("back-in")
    @current = article

  _back = ->
    @current.state("out")
    @current = a.System.Cache.First
    @current.state("back-out")

  _aside = ->
    @current.aside()

  show  : _show
  back  : _back
  aside : _aside
