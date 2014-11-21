###
Event emitter which provides the pub/sub pattern to Atoms classes.

@namespace Atoms.Core
@class Event

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

EVENTS_DESKTOP =
  touch             : "click"
  doubleTap         : "dblClick"

Atoms.Core.Event =

  ###
  Attach a handler to an event for the class.
  @method bind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  A function to execute each time the event is triggered.
  ###
  bind: (events, callback) ->
    events = events.split(' ')
    @events = @events or {}
    for event in events
      event = @_customEventName event
      @events[event] or = []
      @events[event].push callback

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
    events = if @hasOwnProperty('events') then @events?[event]
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
  bubble: (event, hierarchy...) ->
    bubbled = true
    if hierarchy.length is 1
      bubbled = false unless event in (@attributes.events or [])
    if bubbled and @parent?.uid?
      hierarchy.push @
      @_state @parent, event, hierarchy, "bubble"

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
      for child in @children when child.uid?
        @_state child, event, args, "tunnel"


  ###
  Binds to user interface events.
  @method handleInputEvent
  ###
  handleInputEvent: ->
    for event in @attributes.events
      event_desktop = EVENTS_DESKTOP[event] unless $$?
      @el.on event_desktop or event, do (event) => (handler) =>
        unless @el[0].disabled is true then @bubble event, handler

  # Private Methods
  _customEventName: (event) ->
    base = @_base @constructor
    ("#{@constructor.type}:#{base}:#{event}").toLowerCase()

  _base: (constructor) ->
    constructor.base or constructor.name

  _state: (instance, event, args, type="bubble") ->
    # Custom Callback (only for bubble events)
    if type is "bubble"
      indexEvent = @attributes.events?.indexOf event
      if indexEvent > -1
        callback = @attributes.callbacks?[indexEvent]
        args[0].eventCustomCallback = callback if callback

      # Recursive Callback
      callback = args[0].eventCustomCallback unless callback

      # Default Callback
      unless callback
        constructor = if args.length is 1 then @constructor else args[1].constructor
        base = @_base constructor
        base = constructor.name if constructor.extends
        callback = "on#{base.toClassName()}#{event.toClassName()}"

    else if type is "tunnel"
      callback = event

    # Add type
    args[0].eventType = type

    # Dispatch event to instance
    unless instance[callback]?.apply(instance, args) is false
      # Recursive event
      instance[type].apply instance, [event].concat(args)
