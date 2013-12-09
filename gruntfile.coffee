module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    meta:
      build   : 'build',
      bower   : 'bower_components/atoms',
      version : '',
      banner  : '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
              '   <%= pkg.homepage %>\n' +
              '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
              ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'

    source:
      # CoffeeScript
      core: [
        'source/core/atoms.coffee'
        'source/core/*.coffee'
        'source/core/class/*.coffee']
      app: [
        'source/app/*.coffee'
        'source/app/atom/*.coffee'
        'source/app/molecule/*.coffee'
        'source/app/organism/*.coffee'
        'source/app/template/*.coffee']
      example: [
        'example/source/*/*.coffee'
        'example/source/*.coffee']

      spec  : [
        'spec/*.coffee'],

      # Stylesheets
      stylus:
        app: [
          'style/app/reset.styl'
          'style/app/atom.*.styl'
          'style/app/molecule.*.styl'
          'style/app/organism.*.styl'
          'style/app/template.*.styl'
          'style/app/app.styl']
        theme: [
          'style/theme/reset.styl'
          'style/theme/atom.*.styl'
          'style/theme/molecule.*.styl'
          'style/theme/organism.*.styl'
          'style/theme/template.*.styl'
          'style/theme/app.styl']
        icons: [
          'bower_components/atoms_icons/*.styl']

      sass:
        app:
          files: [
            'stylesheet/app.scss'
            'stylesheet/app/*.scss']
          compile: 'stylesheet/app.scss'

        theme:
          files: [
            'stylesheet/theme.scss'
            'stylesheet/theme/*.scss']
          compile: 'stylesheet/theme.scss'


    concat:
      core    : files: '<%=meta.build%>/<%=pkg.name%>.debug.coffee'   : '<%= source.core %>'
      app     : files: '<%=meta.build%>/<%=pkg.name%>.app.coffee'     : '<%= source.app %>'
      example : files: '<%=meta.build%>/<%=pkg.name%>.example.coffee' : '<%= source.example %>'


    coffee:
      core    : files: '<%=meta.build%>/<%=pkg.name%>.debug.js'       : '<%=meta.build%>/<%=pkg.name%>.debug.coffee'
      app     : files: '<%=meta.build%>/<%=pkg.name%>.app.js'         : '<%=meta.build%>/<%=pkg.name%>.app.coffee'
      spec    : files: '<%=meta.build%>/<%=pkg.name%>.spec.js'        : '<%= source.spec %>'
      example : files: '<%=meta.build%>/<%=pkg.name%>.example.js'     : '<%=meta.build%>/<%=pkg.name%>.example.coffee'


    uglify:
      options: mangle: false, banner: "<%= meta.banner %>", # report: "gzip"
      core: files: '<%=meta.bower%>/<%=pkg.name%>.js': '<%=meta.build%>/<%=pkg.name%>.debug.js'
      app : files: '<%=meta.bower%>/<%=pkg.name%>.app.js': '<%=meta.build%>/<%=pkg.name%>.app.js'


    jasmine:
      pivotal:
        src: [
          '<%=meta.build%>/<%=pkg.name%>.debug.js']
        options:
          vendor: 'spec/components/jquery/jquery.min.js'
          specs: '<%=meta.build%>/<%=pkg.name%>.spec.js',
          # outfile: 'spec.html'
          # keepRunner: true


    stylus:
      app:
        options: compress: true, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.app.css': '<%=source.stylus.app%>'
      theme:
        options: compress: false, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.app.theme.css': '<%=source.stylus.theme%>'
      icons:
        options: compress: false
        files: '<%=meta.bower%>_icons/<%=pkg.name%>.icons.css': '<%=source.stylus.icons%>'


    sass:
      app:
        files: '<%=meta.bower%>/<%=pkg.name%>.app.css': '<%=source.sass.app.compile%>'
      theme:
        files: '<%=meta.bower%>/<%=pkg.name%>.app.theme.css': '<%=source.sass.theme.compile%>'

    notify:
      core:
        options: title: 'CoffeeScript', message: 'Core builded.'
      app:
        options: title: 'CoffeeScript', message: 'App builded.'

    watch:
      core:
        files: ['<%= source.core %>']
        tasks: ['concat:core', 'coffee:core', 'jasmine', 'notify:core']
      spec:
        files: ['<%= source.spec %>']
        tasks: ['coffee:spec', 'jasmine']
      app:
        files: ['<%= source.app %>']
        tasks: ['concat:app', 'coffee:app', 'notify:app']
      example:
        files: ['<%= source.example %>']
        tasks: ['concat:example', 'coffee:example']
      stylus_app:
        files: ['<%= source.stylus.app %>']
        tasks: ['stylus:app']
      stylus_theme:
        files: ['<%= source.stylus.theme %>']
        tasks: ['stylus:theme']
      stylus_icons:
        files: ['<%= source.stylus.icons %>']
        tasks: ['stylus:icons']
      sass_app:
        files: ['<%= source.sass.app.files %>']
        tasks: ['sass:app']
      sass_theme:
        files: ['<%= source.sass.theme.files %>']
        tasks: ['sass:theme']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['concat', 'coffee', 'uglify', 'jasmine', 'stylus', 'sass']
