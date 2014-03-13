module.exports = function (grunt) {

  grunt.initConfig({
    //our Grunt task settings
    pkg: grunt.file.readJSON('package.json'),

    sass: {
      dist: {
        options: {
          style: 'compressed',
          require: ['./app/styles/sass/helpers/url64.rb']
        },
       expand: true,
       cwd: './app/styles/sass/',
       src: ['*.scss'],
       dest: './app/styles/',
       ext:  '.css'
      },
      dev: {
        options: {
          style: 'expanded',
          debugInfo: true,
          lineNumbers: true,
          require: ['./app/styles/sass/helpers/url64.rb']
        },
        expand: true,
        cwd: './app/styles/sass/',
        src: ['*.scss'],
        dest: './app/styles/',
        ext: '.css'
      }
    }
    });

  grunt.registerTask('default', ['sass:dist']);
  grunt.loadNpmTasks('grunt-contrib-sass');

};
