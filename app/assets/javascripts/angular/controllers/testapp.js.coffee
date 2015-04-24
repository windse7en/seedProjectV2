app = angular.module('myApp', [])
app.controller('myCtrl', ($scope) ->
    $scope.firstName= "John"
    $scope.lastName= "Doe"
    $scope.fullName = () -> $scope.firstName+' '+$scope.lastName
    $scope.salary = 60000
)

app.controller('customersCtrl', ($scope, $http)->
    $http.get('http://www.w3schools.com/angular/customers.php')
        .success( (response)->
            $scope.names = response.records
        )
)
