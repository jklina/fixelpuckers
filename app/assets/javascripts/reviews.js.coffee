app = angular.module("FixelPuckers", ["ngResource"])

@VotesCtrl = ($scope, $resource) ->
  Vote = $resource("/vote/:action/:votable_type/:votable_id",
    votable_type: "@votable_type"
    votable_id: "@votable_id"
  ,
    vote_up:
      method: "POST"
      params:
        action: "up"

    vote_down:
      method: "POST"
      params:
        action: "down"

    delete:
      method: "DELETE"
  )
  $scope.vote_up = ->
    alert 
    alert Vote.vote_up()
