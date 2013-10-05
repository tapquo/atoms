###
Event emitter which provides the observer pattern to Atoms classes.

@namespace Atoms
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.EventEmitter =

  bind: (event, callback) ->
    event = @_getNameOfEvent(@type, @className, event)
    @_events = @_events or {}
    @_events[event] = @_events[event] or []
    @_events[event].push callback

  unbind: (event, callback) ->
    event = @_getNameOfEvent(@type, @className, event)
    @_events = @_events or {}
    return  if event of @_events is false
    @_events[event].splice @_events[event].indexOf(callback), 1

  trigger: (event) ->
    event = @_getNameOfEvent(@type, @className, event)
    @_events = @_events or {}
    return  if event of @_events is false
    i = 0

    while i < @_events[event].length
      @_events[event][i].apply this, Array::slice.call(arguments, 1)
      i++

  _getNameOfEvent: (type="", className, event) ->
    ("#{type.toLowerCase()}_#{className.toLowerCase()}_#{event}").toLowerCase()

