'use strict'

appPackageService = ($resource) -> $resource '/app_package', {},
  latest:
    method:'GET', params:{last:true}



angular.module('kulebaoAdmin')
.factory('appPackageService', ['$resource', appPackageService])
