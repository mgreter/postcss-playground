var gulp = require('gulp')
var sass = require('gulp-sass');
var post = require('gulp-postcss');
var nested = require('postcss-nested');
var extend = require('postcss-extend');
var loopfor = require('postcss-for');
// var importC = require('postcss-import')();
// var variabs = require('postcss-css-variables')();


gulp.task('postcss-extend', function() {
	return gulp.src('test/extend.scss')
		.pipe(post([extend]))
		.pipe(gulp.dest('postcss'));
})

gulp.task('sass-extend', function() {
	return gulp.src('test/extend.scss')
		.pipe(sass({outputStyle: 'expanded'}))
		.pipe(gulp.dest('sass'));
})

gulp.task('postcss-for-loop', function() {
	return gulp.src('test/for-loop.scss')
		.pipe(post([loopfor]))
		.pipe(gulp.dest('postcss'));
})

gulp.task('sass-for-loop', function() {
	return gulp.src('test/for-loop.scss')
		.pipe(sass({outputStyle: 'expanded'}))
		.pipe(gulp.dest('sass'));
})

gulp.task('postcss-nested', function() {
	return gulp.src('test/nested.scss')
		.pipe(post([nested]))
		.pipe(gulp.dest('postcss'));
})

gulp.task('sass-nested', function() {
	return gulp.src('test/nested.scss')
		.pipe(sass({outputStyle: 'expanded'}))
		.pipe(gulp.dest('sass'));
})

/*

// do not run them in parallel!

gulp.task('sass', ['sass-nested', 'sass-extend']);
gulp.task('postcss', ['postcss-nested', 'postcss-extend']);

gulp.task('nested', ['sass-nested', 'postcss-nested']);
gulp.task('extend', ['sass-extend', 'postcss-extend']);

gulp.task('default', ['sass', 'postcss']);

*/