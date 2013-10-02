###
Event emitter which provides the observer pattern to Atoms classes.

@namespace Atoms
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.EventEmitter =

  bind: (event, callback) ->
    @_events = @_events or {}
    @_events[event] = @_events[event] or []
    @_events[event].push callback

  unbind: (event, callback) ->
    @_events = @_events or {}
    return  if event of @_events is false
    @_events[event].splice @_events[event].indexOf(callback), 1

  trigger: (event, args...) ->
    @_events = @_events or {}
    return  if event of @_events is false
    i = 0

    while i < @_events[event].length
      @_events[event][i].apply this, Array::slice.call(args, 1)
      i++
