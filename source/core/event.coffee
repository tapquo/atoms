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
      event = @_parseName event
      calls[event] or = []
      calls[event].push callback

  ###
  Remove a previously-attached event handler from the class.
  @method unbind
  @param  {string}    A string containing one or more event/custom types.
  @param  {function}  The function that is to be no longer executed.
  ###
  unbind: (event, callback) ->
    event = @_parseName event
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
    event = @_parseName event
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
    if @parentClass
      if args.length is 1
        callbackName = "event_#{@constructor.name}_#{event}"
      else
        callbackName = "event_#{args[1].constructor.name}_#{event}"

      args.push @
      # Dispatch event to parentClass
      @parentClass[callbackName.toLowerCase()]?.apply(@parentClass, args)
      # Bubble event
      @parentClass.bubble.apply @parentClass, [event].concat(args)

  ###
  Attach a handler to a list of a events for the class.
  @method bindList
  @param  {DOM}       Element in DOM.
  @param  {string}    Name of class.
  @param  {array}     List of events to subscribe.
  ###
  bindList: (instance, events) ->
    class_lower = instance.constructor.name.toLowerCase()
    for event in events
      callback_name = "#{class_lower}#{Atoms.Core.Helper.className(event)}"
      instance.bind event, @[callback_name]

  # Private Methods
  _parseName: (event) ->
    ("#{@constructor.type}:#{@constructor.name}:#{event}").toLowerCase()
