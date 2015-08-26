var gulp = require('gulp')
var sass = require('gulp-sass');
var post = require('gulp-postcss');
var nested = require('postcss-nested');
var importC = require('postcss-import')();
var variabs = require('postcss-css-variables')();


gulp.task('postcss', function() {
	return gulp.src('test/nested.scss')
		.pipe(post([importC, variabs, nested]))
		.pipe(gulp.dest('postcss'));
})

gulp.task('sass', function() {
	return gulp.src('test/nested.scss')
		.pipe(sass({outputStyle: 'expanded'}))
		.pipe(gulp.dest('sass'));
})