// Karma configuration
// Generated on Tue Nov 19 2013 23:43:48 GMT+0800 (CST)

module.exports = function (config) {
    config.set({

        // base path, that will be used to resolve files and exclude
        basePath: '',


        // frameworks to use
        frameworks: ['jasmine'],


        // list of files / patterns to load in the browser
        files: [
            'public/javascripts/vendor/jquery-1.10.2.min.js',
            'public/javascripts/vendor/jquery-ui.min.js',
            'public/javascripts/vendor/angularjs/angular.js',
            'public/javascripts/vendor/angularjs/angular-ui-router.js',
            'public/javascripts/vendor/**/*.js',
            'public/javascripts/services/*.js',
            'public/javascripts/controllers/*.js',
            'public/javascripts/*.js',
            'test/assets/config/angular-mocks.js',
            'test/assets/**/*.spec.js'
        ],


        // list of files to exclude
        exclude: [

        ],


        // test results reporter to use
        // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
        reporters: ['progress'],


        // web server port
        port: 9876,


        // enable / disable colors in the output (reporters and logs)
        colors: true,


        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel: config.LOG_INFO,


        // enable / disable watching file and executing tests whenever any file changes
        autoWatch: true,


        // Start these browsers, currently available:
        // - Chrome
        // - ChromeCanary
        // - Firefox
        // - Opera
        // - Safari (only Mac)
        // - PhantomJS
        // - IE (only Windows)
        browsers: ['Chrome'],


        // If browser does not capture in given timeout [ms], kill it
        captureTimeout: 60000,


        // Continuous Integration mode
        // if true, it capture browsers, run tests and exit
        singleRun: false
    });
};
