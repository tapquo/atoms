'use strict'

gulp    = require 'gulp'
coffee  = require 'gulp-coffee'
concat  = require 'gulp-concat'
connect = require 'gulp-connect'
header  = require 'gulp-header'
jasmine = require 'gulp-jasmine'
jasmine = require 'gulp-jasmine'
karma   = require 'gulp-karma'
uglify  = require 'gulp-uglify'
gutil   = require 'gulp-util'
stylus  = require 'gulp-stylus'
yml     = require 'gulp-yml'
pkg     = require './package.json'

path =
  bower      : "./bower"
  temp       : "./build"
  kitchensink: "./kitchensink/www/assets"

  quojs: [
    "quojs/source/quo.coffee"
    "quojs/source/quo.ajax.coffee"
    "quojs/source/quo.css.coffee"
    "quojs/source/quo.element.coffee"
    "quojs/source/quo.environment.coffee"
    "quojs/source/quo.events.coffee"
    "quojs/source/quo.gestures.coffee"
    "quojs/source/quo.gestures.*.coffee"
    "quojs/source/quo.output.coffee"
    "quojs/source/quo.query.coffee"
  ]
  core: [
    "source/*.coffee"
    "source/core/*.coffee"
    "source/class/*.coffee"
  ]
  spec: ["spec/*.coffee"]
  icons: "atoms-app/extension/icons/"

app =
  coffee: [
    "atoms-app/*.coffee"
    "atoms-app/atom/*.coffee"
    "atoms-app/molecule/*.coffee"
    "atoms-app/organism/*.coffee"
  ]
  stylus: ["atoms-app/style/*.styl"]
  theme: ["atoms-app/theme/*.styl"]
  extensions: [
    "atoms-app/extension/**/*.coffee"
    "atoms-app/extension/**/*.styl"
  ]
  docs: ["atoms-app/docs/**/*"]

extensions =
  common: ['carousel', 'gmaps', 'leaflet', 'payments', 'inputrange', 'calendar']
  appnima: ['user', 'payment']

kitchensink =
  coffee: "kitchensink/source/**/*.coffee"
  yml   : "kitchensink/source/organisms/*.yml"

test = ["#{path.temp}/spec.js", "#{path.temp}/atoms.js"]

banner = [
  "/**"
  " * <%= pkg.name %> - <%= pkg.description %>"
  " * @version v<%= pkg.version %>"
  " * @link    <%= pkg.homepage %>"
  " * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)"
  " * @license <%= pkg.license %>"
  " */"
  ""
].join("\n")

gulp.task "webserver", ->
  connect.server
    port      : 8000
    livereload: true

gulp.task "core", ->
  gulp.src(path.quojs.concat(path.core)).pipe(concat("atoms.coffee")).pipe(coffee().on("error", gutil.log)).pipe(gulp.dest(path.temp)).pipe(uglify(mangle: true)).pipe(header(banner,
    pkg: pkg
  )).pipe gulp.dest(path.bower)
  gulp.src(path.core).pipe(concat("atoms.standalone.coffee")).pipe(coffee().on("error", gutil.log)).pipe(gulp.dest(path.temp)).pipe(uglify(mangle: true)).pipe(header(banner,
    pkg: pkg
  )).pipe(gulp.dest(path.bower)).pipe connect.reload()

gulp.task "spec", ->
  return true
  gulp.src(path.spec).pipe(concat("spec.coffee")).pipe(coffee()).pipe gulp.dest(path.temp)
  gulp.src(test).pipe(karma(
    configFile: "karma.js"
    action    : "run"
  )).on "error", (err) -> throw errreturn

gulp.task "coffee", ->
  gulp.src(app.coffee).pipe(concat("atoms.app.coffee")).pipe(coffee().on("error", gutil.log)).pipe(uglify(mangle: false)).pipe(header(banner,
    pkg: pkg
  )).pipe(gulp.dest(path.bower)).pipe connect.reload()

gulp.task "stylus", ->
  gulp.src(app.stylus).pipe(concat("atoms.app.styl")).pipe(stylus(
    compress: true
    errors: true
  )).pipe(header(banner,
    pkg: pkg
  )).pipe(gulp.dest(path.bower)).pipe connect.reload()

gulp.task "theme", ->
  gulp.src(app.theme).pipe(concat("atoms.app.theme.styl")).pipe(stylus(
    compress: true
    errors: true
  )).pipe(header(banner,
    pkg: pkg
  )).pipe(gulp.dest(path.bower)).pipe connect.reload()

gulp.task "icons", ->
  gulp.src(path.icons + "*.styl").pipe(concat("atoms.icons.styl")).pipe(stylus(
    compress: true
    errors: true
  )).pipe(header(banner,
    pkg: pkg
  )).pipe gulp.dest(path.icons)

gulp.task "extensions", ->
  process = (key, folder = "") ->
    file = unless folder then "atoms.app.#{key}" else "atoms.app.#{folder}.#{key}"
    folder = "atoms-app/extension/#{folder}/#{key}/"
    gulp.src(folder + "**/*.coffee").pipe(concat("#{file}.coffee")).pipe(coffee().on("error", gutil.log)).pipe(uglify(mangle: false)).pipe gulp.dest(folder)
    gulp.src(folder + "style/*.styl").pipe(concat("#{file}.styl")).pipe(stylus(compress: true)).pipe(gulp.dest(folder)).pipe connect.reload()
  process extension for extension in extensions.common
  process extension, "appnima" for extension in extensions.appnima

gulp.task "docs", ->
  gulp.src(app.docs).pipe gulp.dest(path.bower + "/docs")

gulp.task "kitchensink", ->
  gulp.src(kitchensink.coffee).pipe(concat("atoms.app.kitchensink.coffee")).pipe(coffee().on("error", gutil.log)).pipe(gulp.dest(path.temp)).pipe connect.reload()
  gulp.src(kitchensink.yml).pipe(yml().on("error", gutil.log)).pipe gulp.dest(path.kitchensink + "/scaffolds")

gulp.task "init", ->
  gulp.run ["core", "coffee", "stylus", "theme", "extensions", "docs", "kitchensink"]

gulp.task "default", ->
  gulp.run ["webserver"]
  gulp.watch path.core, ["core", "spec"]
  gulp.watch path.spec, ["spec"]
  gulp.watch path.quojs, ["core", "spec"]
  gulp.watch path.icons + "*.styl", ["icons"]
  gulp.watch app.coffee, ["coffee"]
  gulp.watch app.stylus, ["stylus"]
  gulp.watch app.theme, ["theme"]
  gulp.watch app.extensions, ["extensions"]
  gulp.watch app.docs, ["docs"]
  gulp.watch kitchensink.coffee, ["kitchensink"]
  gulp.watch kitchensink.yml, ["kitchensink"]
  gulp.src(test).pipe karma(
    configFile: "karma.js"
    action: "watch"
  )
