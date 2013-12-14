# Karma configuration
# Generated on Tue Nov 19 2013 23:43:48 GMT+0800 (CST)

module.exports = (config) ->
  config.set(

  # base path, that will be used to resolve files and exclude
    basePath: '',


  # frameworks to use
    frameworks: ['jasmine'],


  # list of files / patterns to load in the browser
    files: [
      'public/javascripts/vendor/jquery-1.10.2.min.js',
      'public/javascripts/vendor/angularjs/angular.min.js',
      'public/javascripts/vendor/angularjs/angular-route.min.js',
      'public/javascripts/vendor/angularjs/angular-ui-router.min.js',
      'public/javascripts/vendor/**/*.js',
      'app/assets/scripts/main.coffee',
      'app/assets/scripts/admin.coffee',
      'app/assets/scripts/services/*.coffee',
      'app/assets/scripts/controllers/**/*.coffee',
      'app/assets/scripts/directives/*.coffee',
      'app/assets/scripts/filters/*.coffee',
      'test/assets/config/jasmine-jquery.js',
      'test/assets/config/angular-mocks.js',
      'test/spec/**/*.coffee'
    ],

    preprocessors:
      "**/*.coffee": ["coffee"]

    coffeePreprocessor:

    # options passed to the coffee compiler
      options:
        bare: true
        sourceMap: false


    # transforming the filenames
      transformPath: (path) ->
        path.replace /\.js$/, ".coffee"

  # list of files to exclude
    exclude: [

    ],


  # test results reporter to use
  # possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['progress'],


  # web server port
    port: 9876,


  # enable / disable colors in the output (reporters and logs)
    colors: true,


  # level of logging
  # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


  # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


  # Start these browsers, currently available:
  # - Chrome
  # - ChromeCanary
  # - Firefox
  # - Opera
  # - Safari (only Mac)
  # - PhantomJS
  # - IE (only Windows)
    browsers: ['Chrome'],


  # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000,


  # Continuous Integration mode
  # if true, it capture browsers, run tests and exit
    singleRun: true,

    plugins: [
      "karma-jasmine",
      'karma-requirejs',
      'karma-coffee-preprocessor',
      'karma-chrome-launcher',
      "karma-phantomjs-launcher"
    ]
  )