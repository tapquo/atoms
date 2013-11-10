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
        'source/app/atom/*.coffee'
        'source/app/molecule/*.coffee'
        'source/app/organism/*.coffee'
        'source/app/template/*.coffee'
        'source/app/system/*.coffee']
      example: [
        'example/*.coffee']

      spec  : [
        'spec/*.coffee'],

      # Stylesheets
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
      core: files: '<%=meta.build%>/<%=pkg.name%>.debug.coffee'   : '<%= source.core %>'
      app : files: '<%=meta.build%>/<%=pkg.name%>.app.coffee'     : '<%= source.app %>'


    coffee:
      core: files: '<%=meta.build%>/<%=pkg.name%>.debug.js'       : '<%=meta.build%>/<%=pkg.name%>.debug.coffee'
      app : files: '<%=meta.build%>/<%=pkg.name%>.app.js'         : '<%=meta.build%>/<%=pkg.name%>.app.coffee'
      spec: files: '<%=meta.build%>/<%=pkg.name%>.spec.js'        : '<%= source.spec %>'
      example: files: '<%=meta.build%>/<%=pkg.name%>.example.js'  : '<%= source.example %>'


    uglify:
      options: report: "gzip", mangle: false, banner: "<%= meta.banner %>"
      core: files: '<%=meta.bower%>/<%=pkg.name%>.js': '<%=meta.build%>/<%=pkg.name%>.debug.js'
      app : files: '<%=meta.bower%>/<%=pkg.name%>.app.js': '<%=meta.build%>/<%=pkg.name%>.app.js'


    jasmine:
      pivotal:
        src: [
          '<%=meta.build%>/<%=pkg.name%>.debug.js',
          '<%=meta.build%>/<%=pkg.name%>.organisms.js',
          '<%=meta.build%>/<%=pkg.name%>.templates.js']
        options:
          vendor: 'spec/components/jquery/jquery.min.js'
          specs: '<%=meta.build%>/<%=pkg.name%>.spec.js',


    sass:
      app:
        files: '<%=meta.bower%>/<%=pkg.name%>.app.css': '<%=source.sass.app.compile%>'
      theme:
        files: '<%=meta.bower%>/<%=pkg.name%>.app.theme.css': '<%=source.sass.theme.compile%>'
    

    watch:
      core:
        files: ['<%= source.core %>']
        tasks: ['concat:core', 'coffee:core', 'jasmine']
      spec:
        files: ['<%= source.spec %>']
        tasks: ['coffee:spec', 'jasmine']
      app:
        files: ['<%= source.app %>']
        tasks: ['concat:app', 'coffee:app']
      example:
        files: ['<%= source.example %>']
        tasks: ['coffee:example']
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
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['concat', 'coffee', 'uglify', 'jasmine', 'sass']
