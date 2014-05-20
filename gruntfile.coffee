module.exports = (grunt) ->
  grunt.initConfig
    pkg         : grunt.file.readJSON 'package.json'
    component   : grunt.file.readJSON 'bower/bower.json'

    meta:
      version   : '',
      banner    : '/* <%= pkg.name %> v<%= grunt.template.today("0.mm.dd") %>\n' +
                '   <%= pkg.homepage %>\n' +
                '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
                ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'

    folder:
      build : 'build/'
      bower : 'bower/'
      app   : 'extensions/app/'
      icons : 'extensions/icons/'
      test  : 'extensions/test/source/'
      quo   : 'components/quojs/source/'

    core:
      coffee: [
        '<%=folder.quo%>quo.coffee'
        '<%=folder.quo%>quo.ajax.coffee'
        '<%=folder.quo%>quo.css.coffee'
        '<%=folder.quo%>quo.element.coffee'
        '<%=folder.quo%>quo.environment.coffee'
        '<%=folder.quo%>quo.events.coffee'
        '<%=folder.quo%>quo.gestures.coffee'
        '<%=folder.quo%>quo.gestures.*.coffee'
        '<%=folder.quo%>quo.output.coffee'
        '<%=folder.quo%>quo.query.coffee'
        'source/*.coffee'
        'source/core/*.coffee'
        'source/class/*.coffee']
      spec: [
        'spec/*.coffee']
      test: [
        '<%=folder.test%>entities/*.coffee'
        '<%=folder.test%>atoms/*.coffee'
        '<%=folder.test%>molecules/*.coffee'
        '<%=folder.test%>organisms/*.coffee'
        '<%=folder.test%>*.coffee']

    app:
      coffee: [
        '<%=folder.app%>*.coffee'
        '<%=folder.app%>atom/*.coffee'
        '<%=folder.app%>molecule/*.coffee'
        '<%=folder.app%>organism/*.coffee']
      stylus: [
        '<%=folder.app%>style/reset.styl'
        '<%=folder.app%>style/atom.*.styl'
        '<%=folder.app%>style/molecule.*.styl'
        '<%=folder.app%>style/organism.*.styl'
        '<%=folder.app%>style/app.styl']
      theme: [
        '<%=folder.app%>theme/reset.styl'
        '<%=folder.app%>theme/atom.*.styl'
        '<%=folder.app%>theme/molecule.*.styl'
        '<%=folder.app%>theme/organism.*.styl'
        '<%=folder.app%>theme/app.styl']

      extension:
        appnima:
          user:
            coffee: '<%=folder.app%>extension/appnima/user/**/*.coffee'
            stylus: '<%=folder.app%>extension/appnima/user/style/*.styl'
        carousel:
          coffee: '<%=folder.app%>extension/carousel/**/*.coffee'
          stylus: '<%=folder.app%>extension/carousel/style/*.styl'
        gmaps:
          coffee: '<%=folder.app%>extension/gmaps/**/*.coffee'
          stylus: '<%=folder.app%>extension/gmaps/style/*.styl'
        stripe:
          coffee: '<%=folder.app%>extension/stripe/**/*.coffee'
          stylus: '<%=folder.app%>extension/stripe/style/*.styl'
        chart:
          coffee: '<%=folder.app%>extension/chart/**/*.coffee'
          stylus: '<%=folder.app%>extension/chart/style/*.styl'

    icons:
      stylus: '<%=folder.icons%>/style/*.styl'

    doc:
      es: 'extensions/app/docs/ES/*.md'

    # ==========================================================================
    # TASKS
    # ==========================================================================
    concat:
      core              : files: '<%=folder.build%>core.coffee'                 : '<%= core.coffee %>'
      # App
      app               : files: '<%=folder.build%>app.coffee'                  : '<%= app.coffee %>'
      app_appnima_user  : files: '<%=folder.build%>app.appnima.user.coffee'     : '<%= app.extension.appnima.user.coffee %>'
      app_carousel      : files: '<%=folder.build%>app.carousel.coffee'         : '<%= app.extension.carousel.coffee %>'
      app_gmaps         : files: '<%=folder.build%>app.gmaps.coffee'            : '<%= app.extension.gmaps.coffee %>'
      app_stripe        : files: '<%=folder.build%>app.stripe.coffee'           : '<%= app.extension.stripe.coffee %>'
      app_chart        : files: '<%=folder.build%>app.chart.coffee'             : '<%= app.extension.chart.coffee %>'
      # Test
      test              :   files: '<%=folder.build%>test.coffee'               : '<%= core.test %>'

    coffee:
      core              : files: '<%=folder.build%>core.js'                     : '<%=folder.build%>core.coffee'
      spec              : files: '<%=folder.build%>spec.js'                     : '<%= core.spec %>'
      # App
      app               : files: '<%=folder.build%>app.js'                      : '<%=folder.build%>app.coffee'
      app_appnima_user  : files: '<%=folder.build%>app.appnima.user.js'         : '<%=folder.build%>app.appnima.user.coffee'
      app_carousel      : files: '<%=folder.build%>app.carousel.js'             : '<%=folder.build%>app.carousel.coffee'
      app_gmaps         : files: '<%=folder.build%>app.gmaps.js'                : '<%=folder.build%>app.gmaps.coffee'
      app_stripe        : files: '<%=folder.build%>app.stripe.js'               : '<%=folder.build%>app.stripe.coffee'
      app_chart        : files: '<%=folder.build%>app.chart.js'                 : '<%=folder.build%>app.chart.coffee'
      # Test
      test              : files: '<%=folder.build%>test.js'                     : '<%=folder.build%>test.coffee'

    uglify:
      options:  banner: "<%= meta.banner %>"#, report: "gzip"
      core:
        options: mangle: true
        files: '<%=folder.bower%><%=pkg.name%>.js'                              : '<%=folder.build%>core.js'
      # App
      app:
        options: mangle: false
        files: '<%=folder.bower%><%=pkg.name%>.app.js'                          : '<%=folder.build%>app.js'
      app_appnima_user:
        options: mangle: false
        files: '<%=folder.app%>extension/appnima/user/<%=pkg.name%>.app.appnima.user.js': '<%=folder.build%>app.appnima.user.js'
      app_carousel:
        options: mangle: false
        files: '<%=folder.app%>extension/carousel/<%=pkg.name%>.app.carousel.js': '<%=folder.build%>app.carousel.js'
      app_gmaps:
        options: mangle: false
        files: '<%=folder.app%>extension/gmaps/<%=pkg.name%>.app.gmaps.js'      : '<%=folder.build%>app.gmaps.js'
      app_stripe:
        options: mangle: false
        files: '<%=folder.app%>extension/stripe/<%=pkg.name%>.app.stripe.js'    : '<%=folder.build%>app.stripe.js'
      app_chart:
        options: mangle: false
        files: '<%=folder.app%>extension/chart/<%=pkg.name%>.app.chart.js'      : '<%=folder.build%>app.chart.js'

    copy:
      doc_es:
        expand  : true
        flatten : true
        src     : '<%= doc.es %>'
        dest    : '<%= folder.bower %>/docs/ES/'

    jasmine:
      pivotal:
        src: '<%=folder.build%>core.js'
        options:
          display : 'short'
          summary : true
          vendor  : 'spec/components/jquery/jquery.min.js'
          specs   : '<%=folder.build%>spec.js',

    stylus:
      # App
      app_stylus:
        options: compress: true, import: ['__init']
        files: '<%=folder.bower%><%=pkg.name%>.app.css'                         : '<%=app.stylus%>'
      app_theme:
        options: compress: true, import: ['__init']
        files: '<%=folder.bower%><%=pkg.name%>.app.theme.css'                   : '<%=app.theme%>'
      app_appnima_user:
        options: compress: true
        files: '<%=folder.app%>extension/appnima/user/<%=pkg.name%>.app.appnima.user.css' : '<%=app.extension.appnima.user.stylus%>'
      app_carousel:
        options: compress: true
        files: '<%=folder.app%>extension/carousel/<%=pkg.name%>.app.carousel.css': '<%=app.extension.carousel.stylus%>'
      app_gmaps:
        options: compress: true
        files: '<%=folder.app%>extension/gmaps/<%=pkg.name%>.app.gmaps.css'     : '<%=app.extension.gmaps.stylus%>'
      app_stripe:
        options: compress: true
        files: '<%=folder.app%>extension/stripe/<%=pkg.name%>.app.stripe.css'   : '<%=app.extension.stripe.stylus%>'
      app_chart:
        options: compress: true
        files: '<%=folder.app%>extension/chart/<%=pkg.name%>.app.chart.css'     : '<%=app.extension.chart.stylus%>'
      # Icons
      icons:
        options: compress: true
        files: '<%=folder.icons%><%=pkg.name%>.icons.css'                       : '<%=icons.stylus%>'

    notify:
      core:
        options: title: 'atoms.js', message: 'grunt:uglify:core'
      spec:
        options: title: 'Atoms Spec', message: 'grunt:jasmine'
      app:
        options: title: 'atoms.app.js', message: 'grunt:uglify:app'
      app_stylus:
        options: title: 'atoms.app.css', message: 'grunt:stylus:app'
      app_theme:
        options: title: 'atoms.app.theme.css', message: 'grunt:stylus:theme'

    watch:
      core:
        files: ['<%= core.coffee %>']
        tasks: ['concat:core', 'coffee:core', 'uglify:core', 'jasmine', 'notify:core']
      spec:
        files: ['<%= core.spec %>']
        tasks: ['coffee:spec', 'jasmine', 'notify:spec']
      test:
        files: ['<%= core.test %>']
        tasks: ['concat:test', 'coffee:test']
      # App
      app_coffee:
        files: ['<%= app.coffee %>']
        tasks: ['concat:app', 'coffee:app', 'uglify:app', 'notify:app']
      app_stylus:
        files: ['<%= app.stylus %>']
        tasks: ['stylus:app_stylus', 'notify:app_stylus']
      app_theme:
        files: ['<%= app.theme %>']
        tasks: ['stylus:app_theme', 'notify:app_theme']
      # App.Extension
      app_appnima_user:
        files: ['<%= app.extension.appnima.user.coffee %>']
        tasks: ['concat:app_appnima_user', 'coffee:app_appnima_user', 'uglify:app_appnima_user']
      app_carousel:
        files: ['<%= app.extension.carousel.coffee %>']
        tasks: ['concat:app_carousel', 'coffee:app_carousel', 'uglify:app_carousel']
      app_gmaps:
        files: ['<%= app.extension.gmaps.coffee %>']
        tasks: ['concat:app_gmaps', 'coffee:app_gmaps', 'uglify:app_gmaps']
      app_stripe:
        files: ['<%= app.extension.stripe.coffee %>']
        tasks: ['concat:app_stripe', 'coffee:app_stripe', 'uglify:app_stripe']
      app_chart:
        files: ['<%= app.extension.chart.coffee %>']
        tasks: ['concat:app_chart', 'coffee:app_chart', 'uglify:app_chart']
      app_appnima_user_stylus:
        files: ['<%= app.extension.appnima.user.stylus %>']
        tasks: ['stylus:app_appnima_user']
      app_carousel_stylus:
        files: ['<%= app.extension.carousel.stylus %>']
        tasks: ['stylus:app_carousel']
      app_gmaps_stylus:
        files: ['<%= app.extension.gmaps.stylus %>']
        tasks: ['stylus:app_gmaps']
      app_stripe_stylus:
        files: ['<%= app.extension.stripe.stylus %>']
        tasks: ['stylus:app_stripe']
      app_chart_stylus:
        files: ['<%= app.extension.chart.stylus %>']
        tasks: ['stylus:app_chart']
      # Icons
      icons:
        files: ['<%= icons.stylus %>']
        tasks: ['stylus:icons']
      # Docs
      doc_es:
        files: ['<%= doc.es %>']
        tasks: ['copy:doc_es']


  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-notify'

  grunt.registerTask 'default', ['concat', 'coffee', 'uglify', 'stylus', 'copy', 'jasmine']
