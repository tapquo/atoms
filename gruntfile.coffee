module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    meta:
      build     : 'build',
      bower     : 'bower',
      extensions: 'extensions',

      ide_nw    : 'examples/ide/node-webkit',
      version   : '',
      banner    : '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
                '   <%= pkg.homepage %>\n' +
                '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
                ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'

    source:
      # CoffeeScript
      core: [
        'components/quojs/source/quo.coffee'
        'components/quojs/source/quo.ajax.coffee'
        'components/quojs/source/quo.css.coffee'
        'components/quojs/source/quo.element.coffee'
        'components/quojs/source/quo.environment.coffee'
        'components/quojs/source/quo.events.coffee'
        'components/quojs/source/quo.gestures.coffee'
        'components/quojs/source/quo.gestures.*.coffee'
        'components/quojs/source/quo.output.coffee'
        'components/quojs/source/quo.query.coffee'
        'source/*.coffee'
        'source/core/*.coffee'
        'source/class/*.coffee']
      app: [
        'extensions/app/source/*.coffee'
        'extensions/app/source/atom/*.coffee'
        'extensions/app/source/molecule/*.coffee'
        'extensions/app/source/organism/*.coffee']
      spec  : [
        'spec/*.coffee']
      example:
          app: [
            'extensions/app/example/**/*.coffee'
            'extensions/app/example/*.coffee']

      extensions:
        app     : []
        appnima : ['extensions/appnima/**/*.coffee']
        gmaps   : ['extensions/gmaps/**/*.coffee']
        carousel: ['extensions/carousel/**/*.coffee']

      # Stylesheets
      stylus:
        app: [
          'extensions/app/style/reset.styl'
          'extensions/app/style/atom.*.styl'
          'extensions/app/style/molecule.*.styl'
          'extensions/app/style/organism.*.styl'
          'extensions/app/style/app.styl']
        theme: [
          'extensions/app/style/theme/reset.styl'
          'extensions/app/style/theme/atom.*.styl'
          'extensions/app/style/theme/molecule.*.styl'
          'extensions/app/style/theme/organism.*.styl'
          'extensions/app/style/theme/app.styl'
        ]
        # Extensions
        icons: [
          'extensions/icons/*.styl']
        appnima: [
          'extensions/appnima/stylesheets/*.styl']
        gmaps: [
          'extensions/gmaps/stylesheets/*.styl']


    coffee:
      options: join: true
      core        : files: '<%=meta.build%>/<%=pkg.name%>.debug.js'               : '<%=meta.build%>/<%=pkg.name%>.debug.coffee'
      spec        : files: '<%=meta.build%>/<%=pkg.name%>.spec.js'                : '<%= source.spec %>'
      # Extension
      app         : files: '<%=meta.build%>/<%=pkg.name%>.app.js'                 : '<%=meta.build%>/<%=pkg.name%>.app.coffee'
      appnima     : files: '<%=meta.build%>/<%=pkg.name%>.app.appnima.js'         : '<%=meta.build%>/<%=pkg.name%>.app.appnima.coffee'
      gmaps       : files: '<%=meta.build%>/<%=pkg.name%>.app.gmaps.js'           : '<%=meta.build%>/<%=pkg.name%>.app.gmaps.coffee'
      # Example
      example_app : files: '<%=meta.build%>/<%=pkg.name%>.example.app.js'         : '<%=meta.build%>/<%=pkg.name%>.example.app.coffee'


    uglify:
      options:  banner: "<%= meta.banner %>"#, report: "gzip"
      core:
        options: mangle: true
        files: '<%=meta.bower%>/<%=pkg.name%>.js'                 : '<%=meta.build%>/<%=pkg.name%>.debug.js'
      # Extensions
      app:
        options: mangle: false
        files: '<%=meta.bower%>/<%=pkg.name%>.app.js'             : '<%=meta.build%>/<%=pkg.name%>.app.js'
      appnima:
        options: mangle: false
        files: '<%=meta.extensions%>/appnima/<%=pkg.name%>.app.appnima.js'       : '<%=meta.build%>/<%=pkg.name%>.app.appnima.js'
      gmaps:
        options: mangle: false
        files: '<%=meta.extensions%>/gmaps/<%=pkg.name%>.app.gmaps.js'       : '<%=meta.build%>/<%=pkg.name%>.app.gmaps.js'


    jasmine:
      pivotal:
        src: [
          '<%=meta.build%>/<%=pkg.name%>.debug.js']
        options:
          vendor: 'spec/components/jquery/jquery.min.js'
          specs: '<%=meta.build%>/<%=pkg.name%>.spec.js',


    stylus:
      app:
        options: compress: true, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.app.css': '<%=source.stylus.app%>'
      theme:
        options: compress: false, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.app.theme.css': '<%=source.stylus.theme%>'
      # Extensions
      icons:
        options: compress: true
        files: '<%=meta.extensions%>/icons/<%=pkg.name%>.icons.css': '<%=source.stylus.icons%>'
      appnima:
        options: compress: true
        files: '<%=meta.extensions%>/appnima/<%=pkg.name%>.app.appnima.css': '<%=source.stylus.appnima%>'
      gmaps:
        options: compress: true
        files: '<%=meta.extensions%>/gmaps/<%=pkg.name%>.app.gmaps.css': '<%=source.stylus.gmaps%>'

    notify:
      core:
        options: title: 'atoms.js', message: 'grunt:uglify:core'
      app:
        options: title: 'atoms.app.js', message: 'grunt:uglify:app'
      stylus_app:
        options: title: 'atoms.app.css', message: 'grunt:stylus:app'
      stylus_theme:
        options: title: 'atoms.app.theme.css', message: 'grunt:stylus:theme'
      spec:
        options: title: 'Atoms Spec', message: 'grunt:jasmine'


    watch:
      core:
        files: ['<%= source.core %>']
        tasks: ['coffee:core', 'uglify:core']#, 'jasmine', 'notify:core']
      spec:
        files: ['<%= source.spec %>']
        tasks: ['coffee:spec', 'jasmine', 'notify:spec']
      app:
        files: ['<%= source.app %>']
        tasks: ['coffee:app', 'uglify:app', 'notify:app']
      app_appnima:
        files: ['<%= source.extensions.appnima %>']
        tasks: ['coffee:appnima', 'uglify:appnima']
      app_gmaps:
        files: ['<%= source.extensions.gmaps %>']
        tasks: ['coffee:gmaps', 'uglify:gmaps']
      stylus_app:
        files: ['<%= source.stylus.app %>']
        tasks: ['stylus:app', 'notify:stylus_app']
      stylus_theme:
        files: ['<%= source.stylus.theme %>']
        tasks: ['stylus:theme', 'notify:stylus_theme']
      stylus_icons:
        files: ['<%= source.stylus.icons %>']
        tasks: ['stylus:icons']
      stylus_appnima:
        files: ['<%= source.stylus.appnima %>']
        tasks: ['stylus:appnima']
      stylus_gmaps:
        files: ['<%= source.stylus.gmaps %>']
        tasks: ['stylus:gmaps']
      example_app:
        files: ['<%= source.example.app %>']
        tasks: ['coffee:example_app']


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffee', 'uglify', 'stylus', 'jasmine']
