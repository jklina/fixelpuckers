app = angular.module("FixelPuckers", ["ngResource"])

@VotesCtrl = ($scope, $resource) ->
  Vote = $resource("/votes/:votable_type/:votable_id", { id: "@id" }, {vote_up: {method: "POST",params: {verb:'up'}}} )

  $scope.vote_up = ->
    alert(Vote.vote_up())

