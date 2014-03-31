###
Entity Namespace

@namespace Atoms.Core.Class
@class Entity

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Entity extends Atoms.Core.Module

  @extend Atoms.Core.Event

  @records    = {}
  @attributes = []

  # ---------------------------------------------------------------------------
  # Static Methods
  # ---------------------------------------------------------------------------
  @fields: (attributes...) ->
    @records    = {}
    @attributes = attributes or []
    do @unbind
    @

  @create: (attributes) ->
    record = new @ attributes
    record.save()

  @exists: (uid) ->
    try
      @find uid
      true
    catch e
      false

  @find: (uid) ->
    record = @records[uid]
    throw new Error('Unknown UID record') unless record
    record.clone()

  @findBy: (name, value) ->
    for uid, record of @records when record[name] is value
      return record.clone()
    throw new Error 'Unknown record'

  @select: (callback) ->
    @cloneArray (record for uid, record of @records when callback(record))

  @each: (callback) ->
    callback(value.clone()) for key, value of @records

  @all: ->
    @cloneArray(@recordsValues())

  @count: ->
    @recordsValues().length

  @cloneArray: (array) ->
    (value.clone() for value in array)

  @recordsValues: ->
    result = []
    result.push(value) for key, value of @records
    result

  @destroyAll: ->
    # @TODO: Test if remove correctly
    # record.destroy() for uid, record of @records
    @records = {}

  # ---------------------------------------------------------------------------
  # Instance Methods
  # ---------------------------------------------------------------------------
  constructor: (attributes) ->
    super
    @constructor.constructor.type = "Entity"
    @constructor.constructor.base = @constructor.name
    @className = @constructor.name
    @load attributes if attributes

  isNew: ->
    not @exists()

  exists: ->
    @uid && @uid of @constructor.records

  load: (attributes) ->
    for key, value of attributes
      if typeof @[key] is 'function'
        @[key](value)
      else
        @[key] = value
    @

  attributes: ->
    result = {}
    for key in @constructor.attributes when key of this
      if typeof @[key] is 'function'
        result[key] = @[key]()
      else
        result[key] = @[key]
    result

  equal: (record) ->
    !!(record?.constructor is @constructor and record.uid is @uid)

  save: ->
    error = @validate() if @validate?
    if error
      @trigger 'error', error
    else
      record = if @isNew() then @create() else @update()
      @trigger 'save'
      record

  updateAttributes: (attributes) ->
    @load attributes
    @save()

  create: ->
    record = new @constructor @attributes()
    record.uid = @uid
    @constructor.records[@uid] = record
    @trigger 'create'
    @trigger 'change'
    record.clone()

  update: ->
    records = @constructor.records
    records[@uid].load @attributes()
    @trigger 'update'
    @trigger 'change'
    records[@uid].clone()

  destroy: ->
    delete @constructor.records[@uid]
    @trigger 'destroy'
    @trigger 'change'
    @unbind()

  clone: ->
    Object.create @

  unbind: ->
    @trigger 'unbind'

  trigger: (args...) ->
    args.splice(1, 0, @)
    @constructor.trigger args...

# Utilities & Shims
unless typeof Object.create is 'function'
  Object.create = (o) ->
    Func = ->
    Func.prototype = o
    new Func()
