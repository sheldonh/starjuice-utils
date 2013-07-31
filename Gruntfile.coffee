module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      build:
        src: 'build/'
        force: true
      lib:
        src: 'lib/'
        force: true

    copy:
      lib:
        expand: true
        cwd: 'build/'
        src: 'lib/**/*.js'
        dest: '.'

    coffee:
      lib:
        expand: true
        cwd: 'src/'
        src: '**/*.coffee'
        dest: 'build/lib'
        ext: '.js'
      tests:
        expand: true
        cwd: 'test/'
        src: '**/*.coffee'
        dest: 'build/test'
        ext: '.js'

    mochaTest:
      test:
        src: 'build/test/**/*-test.js'
        options: {reporter: 'tap'}

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.registerTask 'default', 'Clean, build & test', ['clean', 'coffee', 'copy', 'mochaTest']
