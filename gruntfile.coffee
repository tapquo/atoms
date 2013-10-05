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
        'source/atoms/*.coffee',
        'source/molecules/*.coffee',
        'source/organisms/*.coffee',
        'source/templates/*.coffee',
        'source/pages/*.coffee']

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

    watch:
      coffee:
        files: ['<%= source.coffee %>']
        tasks: ['coffee:core']
      spec:
        files: ['<%= source.spec %>']
        tasks: ['coffee:spec', 'jasmine']


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffee', 'uglify', 'jasmine']
