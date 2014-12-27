angular.module('DaisyApp').directive 'list', [
  '$loader', '$alert'
  ($loader, $alert) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/list.html"
      scope:
        listUrl: "@"
        listData: "=?"
        listFin: "=?"
        listTitle: "@"
        listMore: "@"
        listMoreLink: "@"
        listLoadMore: "@"
      link: (scope, element, attrs) ->
        if scope.listUrl
          $loader.get(scope.listUrl)
            .success (json) ->
              scope.listFin = json.fin
              # $alert.info(json.data)
              scope.listData = json.data

        scope.link = (data) ->
          data.url || "#/detail/#{data.template}/#{data.id}" unless data.nolink
          
        scope.templateUrl = (data) ->
          "templates/lists/#{data.template}.html"


      controller: [
        '$scope', '$loader', '$alert'
        ($scope, $loader, $alert) ->
          $scope.addthumb = (hospital_onsale) ->
            url = "/api/hospitals/thumb.json"
            params = angular.extend { id: hospital_onsale.id }, params
            # $alert.info(id)
            $loader.get(url, params: params)
              .success (json) ->
                hospital_onsale.thumb = json.data.thumb
                # $alert.info(json.data)
      ]
]
