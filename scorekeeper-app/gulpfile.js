'use strict';

var gulp = require('gulp'),
  exec = require('child_process').exec,
  gutil = require('gulp-util'),
  connect = require('gulp-connect'),
  clear = require('clear'),
  livereload = require('gulp-livereload'),
  counter = 0;

var cmd = 'elm make ./Main.elm --output ./main.js';
clear();

gulp.task('server', function(done) {
  gutil.log(gutil.colors.blue('Starting server at http://localhost:4000'));
  connect.server({
    port: 4000,
    livereload: true
  });
});

gulp.task('elm', function(cb) {
  console.log('E_L_M');
  if (counter > 0){
    clear();
  }
  exec(cmd, function(err, stdout, stderr) {
    if (err){
      gutil.log(gutil.colors.red('elm make: '),gutil.colors.red(stderr));
    } else {
      gutil.log(gutil.colors.green('elm make: '), gutil.colors.green(stdout));
    }
    cb();
  });
  counter++;
});

gulp.task('reload', function(cb) {
  livereload.listen({
    start: true,
    reloadPage: './*.html'
  })
  cb();
})

gulp.task('watch', function(cb) {
  gulp.watch('./*.elm', gulp.series('elm'))
  gulp.watch('./*.html', gulp.series('reload')) 
  
  cb();
});

gulp.task('default', gulp.series('watch', 'server' ));
