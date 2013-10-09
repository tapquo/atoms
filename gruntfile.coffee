module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    meta:
      build   : 'build',
      bower   : 'component',
      version : '',
      banner  : '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
              '   <%= pkg.homepage %>\n' +
              '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
              ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'

    source:
      coffee: [
        'source/atoms.coffee',
        'source/core/*.coffee',
        'source/class/*.coffee',
        'source/atom/*.coffee',
        'source/molecule/*.coffee',
        'source/organism/*.coffee',
        'source/template/*.coffee']

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

      spec  : [
        'spec/*.coffee']

    coffee:
      core: files: '<%=meta.build%>/<%=pkg.name%>.debug.js' : '<%= source.coffee %>'
      spec: files: '<%=meta.build%>/<%=pkg.name%>.spec.js'  : '<%= source.spec %>'


    uglify:
      options: compress: false, banner: "<%= meta.banner %>"
      core: files: '<%=meta.bower%>/<%=pkg.name%>.js': '<%=meta.build%>/<%=pkg.name%>.debug.js'


    jasmine:
        pivotal:
          src: '<%=meta.build%>/<%=pkg.name%>.debug.js'
          options:
            vendor: 'spec/components/jquery/jquery.js'
            specs: '<%=meta.build%>/<%=pkg.name%>.spec.js',


    stylus:
      base:
        options: compress: true, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.css': '<%=source.stylus.base%>'
      theme:
        options: compress: false, import: [ '__init']
        files: '<%=meta.bower%>/<%=pkg.name%>.theme.css': '<%=source.stylus.theme%>'


    watch:
      coffee:
        files: ['<%= source.coffee %>']
        tasks: ['coffee:core']
      spec:
        files: ['<%= source.spec %>']
        tasks: ['coffee:spec', 'jasmine']
      stylus_base:
        files: ['<%= source.stylus.base %>']
        tasks: ['stylus:base']
      stylus_theme:
        files: ['<%= source.stylus.theme %>']
        tasks: ['stylus:theme']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffee', 'uglify', 'jasmine', 'stylus']
