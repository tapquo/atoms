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
        'source/atoms.coffee',
        'source/core/*.coffee',
        'source/core/class/*.coffee',
        'source/atom/*.coffee',
        'source/molecule/*.coffee']
      spec  : [
        'spec/*.coffee'],
      organisms: [
        'source/organism/*.coffee'],
      templates: [
        'source/template/*.coffee']
      example: [
        'example/*.coffee']
      # Stylus
      stylus:
        base: [
          'style/base/reset.styl',
          'style/base/class.styl',
          'style/base/atom.*.styl',
          'style/base/molecule.*.styl',
          'style/base/organism.*.styl']
        theme: [
          'style/theme/reset.styl',
          'style/theme/atom.*.styl',
          'style/theme/molecule.*.styl',
          'style/theme/organism.*.styl']
        templates: [
          'style/theme/template.*.styl']
        icons: [
          'bower_components/atoms_icons/*.styl']

    coffee:
      core: files: '<%=meta.build%>/<%=pkg.name%>.debug.js'         : '<%= source.core %>'
      spec: files: '<%=meta.build%>/<%=pkg.name%>.spec.js'          : '<%= source.spec %>'
      organisms: files: '<%=meta.build%>/<%=pkg.name%>.organisms.js': '<%= source.organisms %>'
      templates: files: '<%=meta.build%>/<%=pkg.name%>.templates.js': '<%= source.templates %>'
      example: files: '<%=meta.build%>/<%=pkg.name%>.example.js'    : '<%= source.example %>'


    uglify:
      options: compress: false, banner: "<%= meta.banner %>"
      core: files: '<%=meta.bower%>/<%=pkg.name%>.js': '<%=meta.build%>/<%=pkg.name%>.debug.js'
      organisms: files: '<%=meta.bower%>/<%=pkg.name%>.organisms.js': '<%=meta.build%>/<%=pkg.name%>.organisms.js'
      templates: files: '<%=meta.bower%>/<%=pkg.name%>.templates.js': '<%=meta.build%>/<%=pkg.name%>.templates.js'


    jasmine:
        pivotal:
          src: [
            '<%=meta.build%>/<%=pkg.name%>.debug.js',
            '<%=meta.build%>/<%=pkg.name%>.organisms.js',
            '<%=meta.build%>/<%=pkg.name%>.templates.js']
          options:
            vendor: 'spec/components/jquery/jquery.min.js'
            specs: '<%=meta.build%>/<%=pkg.name%>.spec.js',


    stylus:
      base:
        options: compress: true, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.css': '<%=source.stylus.base%>'
      theme:
        options: compress: false, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.theme.css': '<%=source.stylus.theme%>'
      templates:
        options: compress: false, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.templates.css': '<%=source.stylus.templates%>'
      icons:
        options: compress: false
        files: '<%=meta.bower%>_icons/<%=pkg.name%>.icons.css': '<%=source.stylus.icons%>'

    watch:
      core:
        files: ['<%= source.core %>']
        tasks: ['coffee:core', 'jasmine']
      spec:
        files: ['<%= source.spec %>']
        tasks: ['coffee:spec', 'jasmine']
      organisms:
        files: ['<%= source.organisms %>']
        tasks: ['coffee:organisms']
      templates:
        files: ['<%= source.templates %>']
        tasks: ['coffee:templates']
      example:
        files: ['<%= source.example %>']
        tasks: ['coffee:example']
      stylus_base:
        files: ['<%= source.stylus.base %>']
        tasks: ['stylus:base']
      stylus_theme:
        files: ['<%= source.stylus.theme %>']
        tasks: ['stylus:theme']
      stylus_templates:
        files: ['<%= source.stylus.templates %>']
        tasks: ['stylus:templates']
      stylus_icons:
        files: ['<%= source.stylus.icons %>']
        tasks: ['stylus:icons']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffee', 'uglify', 'jasmine', 'stylus']
