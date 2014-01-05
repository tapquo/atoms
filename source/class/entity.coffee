###
Constants

@namespace Atoms.Core
@class Constants

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Entity extends Atoms.Core.Module

  @extend Atoms.Core.Event
  @records    : {}
  @attributes : []


  @fields: (attributes...) ->
    @records    = {}
    @attributes = attributes if attributes.length
    @attributes or =  []
    @unbind()
    @

  # Class Methods
  @create: (attributes) ->
    record = new @(attributes)
    record.save()

  @exists: (uid) ->
    try
      return @find(uid)
    catch e
      return false

  @find: (uid) ->
    record = @records[uid]
    # throw new Error('Unknown record') unless record
    record.clone()

  @findBy: (name, value) ->
    for uid, record of @records
      return record.clone() if record[name] is value
    # throw new Error('Unknown record')

  @select: (callback) ->
    result = (record for uid, record of @records when callback(record))
    @cloneArray(result)

  @each: (callback) ->
    callback(value.clone()) for key, value of @records

  @all: -> @cloneArray(@recordsValues())

  @count: -> @recordsValues().length

  @cloneArray: (array) -> (value.clone() for value in array)

  @recordsValues: ->
    result = []
    result.push(value) for key, value of @records
    result

  @destroyAll: ->
    #@TODO mejor lanzar eventos de que se ha eliminado el modelo no??
    @records = {}

  # Instance Methods
  constructor: (attributes) ->
    super
    @className = @constructor.name
    @load attributes if attributes

  isNew: -> not @exists()

  exists: ->
    @uid && @uid of @constructor.records

  clone: -> createObject(@)

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

  equal: (rec) ->
    !!(rec and rec.constructor is @constructor and
      (rec.uid and rec.uid is @uid))

  save: () ->
    error = @validate() if @validate?
    if error
      @trigger('error', error)
      return false

    @trigger('beforeSave')
    record = if @isNew() then @create() else @update()
    @trigger('save')
    record

  updateAttributes: (attributes) ->
    @load(attributes)
    @save()

  changeUID: (uid) ->
    records = @constructor.records
    records[uid] = records[@uid]
    delete records[@uid]
    @uid = uid
    @save()

  create: ->
    @trigger('beforeCreate')

    record = new @constructor(@attributes())
    record.uid = @uid
    @constructor.records[@uid] = record

    @trigger('create')
    @trigger('change', 'create')
    record.clone()

  update: ->
    @trigger('beforeUpdate')

    records = @constructor.records
    records[@uid].load @attributes()

    @trigger('update')
    @trigger('change', 'update')
    records[@uid].clone()

  destroy: ->
    @trigger('beforeDestroy')
    delete @constructor.records[@uid]
    @trigger('destroy')
    @trigger('change', 'destroy')
    @unbind()
    @

  clone: ->
    Object.create(@)

  unbind: -> @trigger('unbind')

  trigger: (args...) ->
    args.splice(1, 0, @)
    @constructor.trigger(args...)

# Utilities & Shims
unless typeof Object.create is 'function'
  Object.create = (o) ->
    Func = ->
    Func.prototype = o
    new Func()
