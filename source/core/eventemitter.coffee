###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class EventEmitter

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.EventEmitter =

  bindings: null

  ###
  Attach a handler to an event for the class.
  @method bind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  A function to execute each time the event is triggered.
  ###
  bind: (event, callback) ->
    event = @_getNameOfEvent(@type, @className, event)
    @_events = @_events or {}
    @_events[event] = @_events[event] or []
    @_events[event].push callback

  ###
  Remove a previously-attached event handler from the class.
  @method unbind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  The function that is to be no longer executed.
  ###
  unbind: (event, callback) ->
    event = @_getNameOfEvent(@type, @className, event)
    @_events = @_events or {}
    return  if event of @_events is false
    @_events[event].splice @_events[event].indexOf(callback), 1

  ###
  Execute all handlers and behaviors attached to the matched class for the given
  event type.
  @method trigger
  @param  {string}    A string containing one or more event/custom types.
  @param  {array}     [OPTIONAL] Additional parameters to pass along to the event
                      handler.
  ###
  trigger: (event) ->
    event = @_getNameOfEvent @type, @className, event
    @_events = @_events or {}
    return  if event of @_events is false
    i = 0

    while i < @_events[event].length
      parameters = Array::slice.call(arguments, 1)
      parameters.push @
      @_events[event][i].apply @, parameters
      i++

  ###
  Attach a handler to a list of a events for the class.
  @method bindList
  @param  {DOM}       Element in DOM.
  @param  {string}    Name of class.
  @param  {array}     List of events to subscribe.
  ###
  bindList: (el, name, events) ->
    #@TODO: Better if use internal @name
    for event in events
      el.bind event, @["#{name.toLowerCase()}#{Atoms.Core.Helper.name(event)}"]

  # Private Methods
  _getNameOfEvent: (type="", className, event) ->
    ("#{type.toLowerCase()}_#{className.toLowerCase()}_#{event}").toLowerCase()
