"use strict"

// -- DEPENDENCIES -------------------------------------------------------------
var gulp    = require('gulp');
var coffee  = require('gulp-coffee');
var concat  = require('gulp-concat');
var connect = require('gulp-connect');
var header  = require('gulp-header');
var jasmine = require('gulp-jasmine');
// var jasmine = require('gulp-jasmine2-phantomjs');
var uglify  = require('gulp-uglify');
var stylus  = require('gulp-stylus');
var pkg     = require('./package.json');


// -- FILES --------------------------------------------------------------------
var path = {
  // Exports
  bower: './bower',
  temp : './build',
  // Sources
  quojs: ['components/QuoJS/source/quo.coffee',
          'components/QuoJS/source/quo.ajax.coffee',
          'components/QuoJS/source/quo.css.coffee',
          'components/QuoJS/source/quo.element.coffee',
          'components/QuoJS/source/quo.environment.coffee',
          'components/QuoJS/source/quo.events.coffee',
          'components/QuoJS/source/quo.gestures.coffee',
          'components/QuoJS/source/quo.gestures.*.coffee',
          'components/QuoJS/source/quo.output.coffee',
          'components/QuoJS/source/quo.query.coffee'],
  core : ['source/*.coffee', 'source/core/*.coffee', 'source/class/*.coffee'],
  spec : ['spec/*.coffee']};

var app = {
  coffee    : ['extensions/app/*.coffee',
               'extensions/app/atom/*.coffee',
               'extensions/app/molecule/*.coffee',
               'extensions/app/organism/*.coffee'],
  stylus    : ['extensions/app/style/*.styl'],
  theme     : ['extensions/app/theme/*.styl'],
  extensions: ['extensions/app/extension/**/*.coffee',
               'extensions/app/extension/**/*.styl'],
  docs      : ['extensions/app/docs/**/*'],
  example   : ['extensions/test/source/**/*.coffee']};

var extensions = {
  carousel: 'extensions/app/extension/carousel/',
  chart   : 'extensions/app/extension/chart/',
  gmaps   : 'extensions/app/extension/gmaps/',
  leaflet : 'extensions/app/extension/leaflet/',
  stripe  : 'extensions/app/extension/stripe/'};

var appnima = {
  payment: 'extensions/app/extension/appnima/payment',
  user   : 'extensions/app/extension/appnima/user'
};

var banner = ['/**',
  ' * <%= pkg.name %> - <%= pkg.description %>',
  ' * @version v<%= pkg.version %>',
  ' * @link    <%= pkg.homepage %>',
  ' * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)',
  ' * @license <%= pkg.license %>',
  ' */',
  ''].join('\n');

// -- TASKS --------------------------------------------------------------------
gulp.task('webserver', function() {
    connect.server({
      port      : 8000,
      // root      : 'extensions/test',
      livereload: true
    });
});

gulp.task('core', function() {
  gulp.src(path.quojs.concat(path.core))
    .pipe(concat('atoms.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest(path.temp))
    .pipe(uglify({mangle: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
    .pipe(connect.reload())

  gulp.src(path.core)
    .pipe(concat('atoms.standalone.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest(path.temp))
    .pipe(uglify({mangle: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
});

gulp.task('spec', function() {
  gulp.src(path.spec)
    .pipe(concat('atoms.spec.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest(path.temp))

  var spec = [
    'spec/components/quojs/quo.js',
    'build/atoms.standalone.js',
    'build/atoms.spec.js'];

  gulp.src(spec)
    .pipe(jasmine())
});

gulp.task('app_coffee', function() {
  gulp.src(app.coffee)
    .pipe(concat('atoms.app.coffee'))
    .pipe(coffee())
    .pipe(uglify({mangle: false}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
});

gulp.task('app_stylus', function() {
  gulp.src(app.stylus)
    .pipe(concat('atoms.app.styl'))
    .pipe(stylus({compress: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower));
});

gulp.task('app_theme', function() {
  gulp.src(app.theme)
    .pipe(concat('atoms.app.theme.styl'))
    .pipe(stylus({compress: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower));
});

gulp.task('extensions', function() {
  var key, folder;

  for (key in extensions) {
    folder = extensions[key];

    gulp.src(folder + "**/*.coffee")
      .pipe(concat('atoms.app.' + key + '.coffee'))
      .pipe(coffee())
      .pipe(uglify({mangle: false}))
      .pipe(gulp.dest(folder));

    gulp.src(folder + "style/*.styl")
      .pipe(concat('atoms.app.' + key + '.styl'))
      .pipe(stylus({compress: true}))
      .pipe(gulp.dest(folder));
  }
});

gulp.task('docs', function() {
  gulp.src(app.docs)
    .pipe(gulp.dest(path.bower + "/docs"));
});

gulp.task('example', function() {
  gulp.src(app.example)
    .pipe(concat('atoms.app.example.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest(path.temp))
    .pipe(connect.reload())
});

gulp.task('init', function() {
  gulp.run(['core', 'app_coffee', 'app_stylus', 'app_theme', 'extensions', 'docs', 'example']);
});

gulp.task('default', function() {
  gulp.run(['webserver'])
  gulp.watch(path.core, ['core', 'spec']);
  gulp.watch(app.coffee, ['app_coffee']);
  gulp.watch(app.stylus, ['app_stylus']);
  gulp.watch(app.theme, ['app_theme']);
  gulp.watch(app.extensions, ['extensions']);
  gulp.watch(app.docs, ['docs']);
  gulp.watch(app.example, ['example']);
});
