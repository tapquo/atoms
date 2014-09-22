"use strict"

// -- DEPENDENCIES -------------------------------------------------------------
var gulp    = require('gulp');
var coffee  = require('gulp-coffee');
var concat  = require('gulp-concat');
var connect = require('gulp-connect');
var header  = require('gulp-header');
var jasmine = require('gulp-jasmine');
var jasmine = require('gulp-jasmine');
var karma   = require('gulp-karma');
var uglify  = require('gulp-uglify');
var gutil   = require('gulp-util');
var stylus  = require('gulp-stylus');
var yml     = require('gulp-yml');
var pkg     = require('./package.json');


// -- FILES --------------------------------------------------------------------
var path = {
  // Exports
  bower       : './bower',
  temp        : './build',
  kitchensink : './kitchensink/www/assets',
  // Sources
  quojs: ['quojs/source/quo.coffee',
          'quojs/source/quo.ajax.coffee',
          'quojs/source/quo.css.coffee',
          'quojs/source/quo.element.coffee',
          'quojs/source/quo.environment.coffee',
          'quojs/source/quo.events.coffee',
          'quojs/source/quo.gestures.coffee',
          'quojs/source/quo.gestures.*.coffee',
          'quojs/source/quo.output.coffee',
          'quojs/source/quo.query.coffee'],
  core : ['source/*.coffee', 'source/core/*.coffee', 'source/class/*.coffee'],
  spec : ['spec/*.coffee'],
  icons: 'atoms-app/extension/icons/'};

var app = {
  coffee      : ['atoms-app/*.coffee',
                 'atoms-app/atom/*.coffee',
                 'atoms-app/molecule/*.coffee',
                 'atoms-app/organism/*.coffee'],
  stylus      : ['atoms-app/style/*.styl'],
  theme       : ['atoms-app/theme/*.styl'],
  extensions  : ['atoms-app/extension/**/*.coffee',
                 'atoms-app/extension/**/*.styl'],
  docs        : ['atoms-app/docs/**/*']};

var kitchensink = {
    coffee    : ['kitchensink/source/**/*.coffee'],
    yml       : ['kitchensink/source/organisms/*.yml']
};

var extensions = {
  carousel: 'atoms-app/extension/carousel/',
  gmaps   : 'atoms-app/extension/gmaps/',
  leaflet : 'atoms-app/extension/leaflet/',
  stripe  : 'atoms-app/extension/stripe/',
  calendar: 'atoms-app/extension/calendar/'};

var appnima = {
  payment: 'atoms-app/extension/appnima/payment/',
  user   : 'atoms-app/extension/appnima/user/'
};

var test = [
  path.temp + '/spec.js',
  path.temp + '/atoms.js'];

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
  connect.server({ port: 8000, /*root: 'www/',*/ livereload: true });
});

gulp.task('core', function() {
  gulp.src(path.quojs.concat(path.core))
    .pipe(concat('atoms.coffee'))
    .pipe(coffee().on('error', gutil.log))
    .pipe(gulp.dest(path.temp))
    .pipe(uglify({mangle: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))

  gulp.src(path.core)
    .pipe(concat('atoms.standalone.coffee'))
    .pipe(coffee().on('error', gutil.log))
    .pipe(gulp.dest(path.temp))
    .pipe(uglify({mangle: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
    .pipe(connect.reload());
});


gulp.task('spec', function() {
  return true
  gulp.src(path.spec)
    .pipe(concat('spec.coffee'))
    .pipe(coffee())
    .pipe(gulp.dest(path.temp));

  gulp.src(test)
    .pipe(karma({
      configFile: 'karma.js',
      action    : 'run'
    }))
    .on('error', function(err) { throw err; });
});

gulp.task('app_coffee', function() {
  gulp.src(app.coffee)
    .pipe(concat('atoms.app.coffee'))
    .pipe(coffee().on('error', gutil.log))
    .pipe(uglify({mangle: false}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
    .pipe(connect.reload());
});

gulp.task('app_stylus', function() {
  gulp.src(app.stylus)
    .pipe(concat('atoms.app.styl'))
    .pipe(stylus({compress: true, errors: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
    .pipe(connect.reload());
});

gulp.task('app_theme', function() {
  gulp.src(app.theme)
    .pipe(concat('atoms.app.theme.styl'))
    .pipe(stylus({compress: true, errors: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.bower))
    .pipe(connect.reload());
});

gulp.task('icons', function() {
  gulp.src(path.icons + "*.styl")
    .pipe(concat('atoms.icons.styl'))
    .pipe(stylus({compress: true, errors: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.icons));
});

gulp.task('extensions', function() {
  var key, folder;

  var process = function(key, folder, file) {
    gulp.src(folder + "**/*.coffee")
      .pipe(concat(file + key + '.coffee'))
      .pipe(coffee().on('error', gutil.log))
      .pipe(uglify({mangle: false}))
      .pipe(gulp.dest(folder));

    gulp.src(folder + "style/*.styl")
      .pipe(concat(file + key + '.styl'))
      .pipe(stylus({compress: true}))
      .pipe(gulp.dest(folder))
      .pipe(connect.reload());
  }

  for (key in extensions) {
    process(key, extensions[key], 'atoms.app.')
  };

  for (key in appnima) {
    process(key, appnima[key], 'atoms.app.appnima.')
  };
});

gulp.task('docs', function() {
  gulp.src(app.docs)
    .pipe(gulp.dest(path.bower + "/docs"));
});

gulp.task('kitchensink', function() {
  gulp.src(kitchensink.coffee)
    .pipe(concat('atoms.app.kitchensink.coffee'))
    .pipe(coffee().on('error', gutil.log))
    .pipe(gulp.dest(path.temp))
    .pipe(connect.reload())

  gulp.src(kitchensink.yml)
    .pipe(yml().on('error', gutil.log))
    .pipe(gulp.dest(path.kitchensink + '/scaffolds'));
});

gulp.task('init', function() {
  gulp.run(['core', 'app_coffee', 'app_stylus', 'app_theme', 'extensions', 'docs', 'kitchensink']);
});

gulp.task('default', function() {
  gulp.run(['webserver'])
  gulp.watch(path.core, ['core', 'spec']);
  gulp.watch(path.spec, ['spec']);
  gulp.watch(path.quojs, ['core', 'spec']);
  gulp.watch(path.icons + "*.styl", ['icons']);
  gulp.watch(app.coffee, ['app_coffee']);
  gulp.watch(app.stylus, ['app_stylus']);
  gulp.watch(app.theme, ['app_theme']);
  gulp.watch(app.extensions, ['extensions']);
  gulp.watch(app.docs, ['docs']);
  gulp.watch(kitchensink.coffee, ['kitchensink']);
  gulp.watch(kitchensink.yml, ['kitchensink']);

  gulp.src(test)
    .pipe(karma({
      configFile: 'karma.js',
      action: 'watch'
  }));
});
