###
HTML Renderer

@namespace Atoms.Core
@class Output

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Output =

  ###
  Insert content to the end of each element in the set of matched elements.
  @method append
  ###
  append: -> @output "append"

  ###
  Insert content to the beginning of each element in the set of matched elements.
  @method prepend
  ###
  prepend: -> @output "prepend"

  ###
  Set the HTML contents of each element in the set of matched elements.
  @method html
  ###
  html: -> @output "html"

  ###
  Render element with the instance @template and @attributes.
  @method output
  ###
  output: ->
    throw "No template defined." unless @constructor.template?
    throw "No container assigned." unless @container?

    do @_render
    # Attributes for constructor
    @constructor.method =  @attributes.method or Atoms.Core.Constants.APPEND

    if typeof(@container) is "string" or not @container.length?
      @container = Atoms.$(@container)
    @container.first()[@constructor.method] @el


  ###
  Refresh element with the new @attributes.
  @method refresh
  @param  {object} [OPTIONAL]  New values for current attributes
  ###
  refresh: (attributes = {}) ->
    @attributes[key] = value for key, value of attributes

    current_el = @el
    @_render()
    @bindEvents?()
    @chemistry?()
    current_el.replaceWith @el

  ###
  Remove element from DOM
  @method destroy
  ###
  destroy: ->
    do @el.remove

  # Private Methods
  _render: ->
    do @_createIfBindings
    @el = Atoms.$(_mustache(@constructor.template)(@attributes))
    base = @constructor.base.toLowerCase() or new String()
    constructor_name = @constructor.name.toLowerCase()
    key = "data-#{@constructor.type}-#{base}".toLowerCase()
    value = if constructor_name isnt base then constructor_name else ""
    @el.attr key, value
    @el

  _createIfBindings: ->
    @attributes.if = {}
    for key of @attributes when key not in Atoms.Core.Constants.EXCLUDED_IF_KEYS
      @attributes.if[key] = true if @attributes[key]

###
The fastest and smallest Mustache compliant Javascript templating library
templayed.js 0.2.1 - (c) 2012 Paul Engel
http://archan937.github.io/templayed.js/
###
_mustache = (template, data) ->
  get = (path, i) ->
    i = 1
    path = path.replace(/\.\.\//g, ->
      i++
      ""
    )
    js = ["data[data.length - ", i, "]"]
    keys = ((if path is "." then [] else path.split(".")))
    index = 0
    while index < keys.length
      js.push "." + keys[index]
      index++
    js.join ""

  tag = (template) ->
    template.replace /\{\{(!|&|\{)?\s*(.*?)\s*}}+/g, (match, operator, context) ->
      return ""    if operator is "!"
      i = inc++
      ["\"; var o", i, " = ", get(context), ", s", i, " = (((typeof(o", i, ") == \"function\" ? o", i, ".call(data[data.length - 1]) : o", i, ") || \"\") + \"\"); s += ", ((if operator then ("s" + i) else "(/[&\"><]/.test(s" + i + ") ? s" + i + ".replace(/&/g,\"&amp;\").replace(/\"/g,\"&quot;\").replace(/>/g,\"&gt;\").replace(/</g,\"&lt;\") : s" + i + ")")), " + \""].join ""


  block = (template) ->
    tag template.replace(/\{\{(\^|#)(.*?)}}(.*?)\{\{\/\2}}/g, (match, operator, key, context) ->
      i = inc++
      ["\"; var o", i, " = ", get(key), "; ", ((if operator is "^" then ["if ((o", i, " instanceof Array) ? !o", i, ".length : !o", i, ") { s += \"", block(context), "\"; } "] else ["if (typeof(o", i, ") == \"boolean\" && o", i, ") { s += \"", block(context), "\"; } else if (o", i, ") { for (var i", i, " = 0; i", i, " < o", i, ".length; i", i, "++) { data.push(o", i, "[i", i, "]); s += \"", block(context), "\"; data.pop(); }}"])).join(""), "; s += \""].join ""
    )

  inc = 0
  new Function("data", "data = [data], s = \"" + block(template.replace(/"/g, "\\\"").replace(/\n/g, "\\n")) + "\"; return s;")
