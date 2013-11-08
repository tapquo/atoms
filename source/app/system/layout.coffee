###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.System.Layout = do (a = Atoms) ->

  current = null

  _show = (article, section) ->
    article = a.System.Cache[a.Core.Helper.className(article)]
    article.state("in")
    @current.state("back-in") if @current
    @current = article

  _back = (article, section) ->
    @current.state("out")
    @current = a.System.Cache[a.Core.Helper.className(article)]
    @current.state("back-out")

  _aside = ->
    @current.aside()

  show  : _show
  back  : _back
  aside : _aside
