###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.System.Layout = do (a = Atoms) ->

  current = undefined

  _show = (article, section) ->
    article = a.System.Cache[a.Core.Helper.className(article)]
    _activeSection article, section
    if current isnt article
      _overwriteStepHistory 1
      article.state("in")
      current.state("back-in") if current
      current = article


  _back = (article, section) ->
    _overwriteStepHistory 0
    article = a.System.Cache[a.Core.Helper.className(article)]
    _activeSection article, section
    if current isnt article
      current.state("out")
      current = article
      current.state("back-out")

  _aside = ->
    current.aside()

  _activeSection = (article, section) ->
    _addStepInHistory()
    article.el.children("section##{section}")
      .addClass("active")
      .siblings().removeClass("active")

  _addStepInHistory = ->
    state = window.history.state or steps: 0
    state.steps++
    window.history.replaceState state

  _overwriteStepHistory = (value) ->
    window.history.replaceState steps: value


  show  : _show
  back  : _back
  aside : _aside
