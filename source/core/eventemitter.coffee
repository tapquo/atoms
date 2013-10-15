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
  bind: (events, callback) ->
    events = events.split(' ')
    calls = @hasOwnProperty('_events') and @_events or = {}
    for event in events
      event = @_getNameOfEvent @type, @className, event
      calls[event] or = []
      calls[event].push callback

  ###
  Remove a previously-attached event handler from the class.
  @method unbind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  The function that is to be no longer executed.
  ###
  unbind: (event, callback) ->
    event = @_getNameOfEvent(@type, @className, event)
    if @hasOwnProperty('_events') and @_events?[event]
      @_events[event].splice @_events[event].indexOf(callback), 1

  ###
  Execute all handlers and behaviors attached to the matched class for the given
  event type.
  @method trigger
  @param  {string}    A string containing one or more event/custom types.
  @param  {array}     [OPTIONAL] Additional parameters to pass along to the event
                      handler.
  ###
  trigger: (event, args...) ->
    event = @_getNameOfEvent @type, @className, event
    events = @hasOwnProperty('_events') and @_events?[event]
    return unless events
    args.push @
    for event in events
      break if event.apply(@, args) is false

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
      el.bind event, @["#{name.toLowerCase()}#{Atoms.Core.Helper.className(event)}"]

  # Private Methods
  _getNameOfEvent: (type="", className="", event) ->
    ("#{type.toLowerCase()}_#{className.toLowerCase()}_#{event}").toLowerCase()
