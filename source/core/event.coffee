###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class Event

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Event =

  bindings: null

  ###
  Attach a handler to an event for the class.
  @method bind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  A function to execute each time the event is triggered.
  ###
  bind: (events, callback) ->
    events = events.split(' ')
    calls = @hasOwnProperty('events') and @events or = {}
    for event in events
      event = @_customEventName event
      calls[event] or = []
      calls[event].push callback

  ###
  Remove a previously-attached event handler from the class.
  @method unbind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  The function that is to be no longer executed.
  ###
  unbind: (event, callback) ->
    event = @_customEventName event
    if @hasOwnProperty('events') and @events?[event]
      @events[event].splice @events[event].indexOf(callback), 1

  ###
  Execute all handlers and behaviors attached to the matched class for the given
  event type.
  @method trigger
  @param  {string}    A string containing one or more event/custom types.
  @param  {array}     [OPTIONAL] Additional parameters to pass along to the event
                      handler.
  ###
  trigger: (event, args...) ->
    event = @_customEventName event
    events = @hasOwnProperty('events') and @events?[event]
    return unless events
    args.push @
    for event in events
      break if event.apply(@, args) is false

  ###
  @TODO: Comment method
  @method bubble
  @param  {string}    A string containing one or more event/custom types.
  @param  {array}     [OPTIONAL] Additional parameters to pass along to the event
                      handler.
  ###
  bubble: (event, args...) ->
    if @parent?.uid?
      callbackName = @_eventCallbackName event, "bubble", args
      args.push @
      @_state @parent, event, callbackName, args, "bubble"

  ###
  @TODO: Comment method
  @method tunnel
  @param  {string}    A string containing one or more event/custom types.
  @param  {array}     [OPTIONAL] Additional parameters to pass along to the event
                      handler.
  ###
  tunnel: (event, args...) ->
    if @children?.length > 0
      callbackName =  @_eventCallbackName event, "tunnel", args
      args.push @
      for child in @children
        @_state child, event, callbackName, args, "tunnel"

  ###
  Attach a handler to a list of a events for the class.
  @method bindList
  @param  {DOM}       Element in DOM.
  @param  {string}    Name of class.
  @param  {array}     List of events to subscribe.
  ###
  bindList: (instance, events) ->
    class_base = @_classBase instance.constructor
    for event in events
      callback_name = "#{class_base.toLowerCase()}#{event.toClassName()}"
      if @[callback_name] then instance.bind event, @[callback_name]

  # Private Methods
  _customEventName: (event) ->
    class_base = @_classBase @constructor
    ("#{@constructor.type}:#{class_base}:#{event}").toLowerCase()

  _eventCallbackName: (event, type, args) ->
    constructor = if args.length is 1 then @constructor else args[1].constructor
    class_base = @_classBase constructor
    callbackName = "#{type}#{class_base.toClassName()}#{event.toClassName()}"

  _classBase: (constructor) ->
    constructor.base or constructor.name

  _state: (instance, event, callback, args, type="bubble") ->
    # Dispatch event to instance
    instance[callback]?.apply instance, args
    # Recursive event
    instance[type].apply instance, [event].concat(args)
