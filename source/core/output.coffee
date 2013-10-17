###
HTML Renderer

@namespace Atoms.Core
@class Output

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms.Core.Output =

  method       : "append"
  conditionals : []

  ###
  Insert content to the end of each element in the set of matched elements.
  @method append
  ###
  append: -> @render "append"

  ###
  Insert content to the beginning of each element in the set of matched elements.
  @method prepend
  ###
  prepend: -> @render "prepend"

  ###
  Set the HTML contents of each element in the set of matched elements.
  @method html
  ###
  html: -> @render "html"

  ###
  Render element with the instance @template and @attributes.
  @method render
  ###
  render: (conditionals = []) ->
    throw "No template defined." unless @constructor.template?
    throw "No parent assigned." unless @attributes?.parent?

    @_createConditionalsBindings()
    @attributes.className = @constructor.name
    @el = Atoms.$ @_mustache(@constructor.template)(@attributes)
    @parent = Atoms.$ @attributes.parent
    @method = @attributes.method if @attributes.method?
    @parent[@method] @el

  # Private Methods
  _createConditionalsBindings: ->
    conditions = {}
    for key of @attributes
      conditions[key] = if @attributes[key]? then true else false
    @attributes.if = conditions

  ###
  The fastest and smallest Mustache compliant Javascript templating library
  templayed.js 0.2.1 - (c) 2012 Paul Engel
  http://archan937.github.io/templayed.js/
  ###
  _mustache: (template, data) ->
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
