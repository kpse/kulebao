// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var Controller;

  Controller = (function() {
    function Controller($rootScope, newsService, readService) {
      var _this = this;
      this.kindergarten = {
        id: 1,
        name: 'school23'
      };
      this.user = {
        id: 1,
        name: '豆瓣'
      };
      $rootScope.tabName = 'bulletin';
      this.newsletters = newsService.bind({
        kg: this.kindergarten.name
      }).query(function() {
        return _this.readNews = readService.bind({
          kg: _this.kindergarten.name,
          parent_id: _this.user.id
        }).query(function() {
          return _this.determineReadOrNot(_this.readNews, _this.newsletters, _this.user);
        });
      });
      this.determineReadOrNot = function(readNews, newsletters, user) {
        var news, _i, _len, _results;
        _.each(newsletters, function(news) {
          return news.read = false;
        });
        _results = [];
        for (_i = 0, _len = readNews.length; _i < _len; _i++) {
          news = readNews[_i];
          _results.push((function(news) {
            var n, _j, _len1, _ref, _results1;
            _ref = newsletters.filter(function(n) {
              return n.id === news.news_id && news.parent_id === user.id;
            });
            _results1 = [];
            for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
              n = _ref[_j];
              _results1.push((function(n) {
                return n.read = true;
              })(n));
            }
            return _results1;
          })(news));
        }
        return _results;
      };
    }

    return Controller;

  })();

  angular.module('kulebaoApp').controller('BulletinCtrl', ['$rootScope', 'newsService', 'readService', Controller]);

}).call(this);
