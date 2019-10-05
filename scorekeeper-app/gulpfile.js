'use strict';

var gulp = require('gulp'),
  exec = require('child_process').exec,
  gutil = require('gulp-util'),
  connect = require('gulp-connect'),
  clear = require('clear'),
  livereload = require('gulp-livereload'),
  counter = 0;

clear();

const runServer = function(cb) {
  gutil.log(gutil.colors.blue('Starting server at http://localhost:4000'));
  connect.server({
    port: 4000,
    livereload: true
  });

  cb();
};

const elmMake = function(cb) {
  if (counter > 0){
    clear();
  }
  exec('elm make ./Main.elm --output ./build/main.js', function(err, stdout, stderr) {
    if (err){
      gutil.log(gutil.colors.red('elm make: '),gutil.colors.red(stderr));
    } else {
      gutil.log(gutil.colors.green('elm make: '), gutil.colors.green(stdout));
    }
    cb();
  });
  counter++;
};

const reloadServer = function(cb) {
  livereload.listen({
    start: true,
    reloadPage: './*.html'
  })
  cb();
};

gulp.task('reload', reloadServer)

gulp.task('elm', elmMake)

gulp.task('server', runServer);

gulp.task('watch', function(cb) {
  gulp.watch('./*.elm', gulp.series('elm'))
  gulp.watch('./*.html', gulp.series('reload'))
  
  cb();
});

gulp.task('start', gulp.series('watch', 'server' ));
