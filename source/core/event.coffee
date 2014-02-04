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
      args.push @
      @_state @parent, event, args, "bubble"

  ###
  @TODO: Comment method
  @method tunnel
  @param  {string}    A string containing one or more event/custom types.
  @param  {array}     [OPTIONAL] Additional parameters to pass along to the event
                      handler.
  ###
  tunnel: (event, args...) ->
    if @children?.length > 0
      args.push @
      for child in @children
        @_state child, event, args, "tunnel"

  # Private Methods
  _customEventName: (event) ->
    class_base = @_classBase @constructor
    ("#{@constructor.type}:#{class_base}:#{event}").toLowerCase()

  _classBase: (constructor) ->
    constructor.base or constructor.name

  _state: (instance, event, args, type="bubble") ->
    # Custom Callback
    indexEvent = @attributes.events?.indexOf event
    if indexEvent > -1
      callback = @attributes.callbacks?[indexEvent]
      args[0].eventCustomCallback = callback if callback

    # Recursive Callback
    callback = args[0].eventCustomCallback unless callback

    # Default Callback
    unless callback
      constructor = if args.length is 1 then @constructor else args[1].constructor
      class_base = @_classBase constructor
      callback = "on#{class_base.toClassName()}#{event.toClassName()}"

    # Add type
    args[0].eventType = type

    # Dispatch event to instance
    unless instance[callback]?.apply(instance, args) is false
      # Recursive event
      instance[type].apply instance, [event].concat(args)
