gulp       = require 'gulp'

browserify = require 'browserify'
reactify   = require 'coffee-reactify'
source     = require 'vinyl-source-stream'

gulp.task 'js', ->
    browserify './public/javascripts/src/main.cjsx'
        .transform reactify
        .bundle()
        .pipe source('main.js')
        .pipe gulp.dest('public/javascripts/build')

gulp.task 'watch', ->
    gulp.watch 'public/javascripts/src/**/*.cjsx', ['js']

gulp.task 'default', ['js', 'watch']
