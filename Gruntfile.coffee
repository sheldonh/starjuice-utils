module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      build:
        src: 'build/'
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

    shell:
      mocha:
        command: 'mocha --recursive --reporter tap build/test'
        options:
          stdout: true
          stderr: true
          failOnError: true
          execOptions:
            env:
              NODE_PATH: 'lib'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'default', 'Clean, build & test', ['clean', 'coffee', 'copy', 'shell:mocha']
