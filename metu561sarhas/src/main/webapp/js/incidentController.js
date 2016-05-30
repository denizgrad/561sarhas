var sipApp = angular.module("incidentModule", [ 'ngMaterial', 'ui.grid']);

sipApp.controller("incidentCtrl", function($scope, $http) {

	$scope.incident = {};

	$scope.proceed = function(form) {
		if ($scope.type.localeCompare("animal") == 0) {
			$scope.selectedValue = true;
		}
	}

	$scope.postMe = function() {
		$http.get('/_ah/api/incident/v1/test', obj).success(function(response) {
			alert("Done");
		}).error(function(error) {
			alert("An error occured during post request");
		});
	}
	$scope.save = function() {
		var obj = {};
		$scope.incident.type = $scope.type;
		obj.jsonIncident = JSON.stringify($scope.incident);
		$http({
			method : 'POST',
			url : '/_ah/api/incident/v1/save',
			data : {
				jsonIncident : JSON.stringify($scope.incident)
			}
		}).then(function() {
			$scope.listAll();
			alert("Done");
		}, function() {
			alert("An error occured during post request");
		});
	}
	
	$scope.listAll = function() {
		var obj = {};
		$http({
			method : 'GET',
			url : '/_ah/api/incident/v1/listAll',
		}).then(function(resp) {
			$scope.gridOptions.data = resp.data.items;
			alert("Done");
		}, function() {
			alert("An error occured during post request");
		});
	}
	
	$scope.gridOptions = {
		    columnDefs: [
		                 { field: 'btnUpdate', displayName: "", cellTemplate: arrangeButtonForUpdate('row'), width : 30},
		                 { field: 'key.id', displayName: "id", visible: false, enableHiding: false},
		                 { field: 'properties.type', displayName: "Type", visible: true, cellTemplate: arrangeComboboxForType('row'), width : 140},
		                 { field: 'properties.title', displayName: "Title", width : 140},
		                 { field: 'properties.completed', displayName: "Completed" , visible: true, cellTemplate: arrangeComboboxForCompleted('row'), width : 140},
		                 { field: 'properties.dangerous', displayName: "Dangerous" , visible: true, cellTemplate: arrangeComboboxForDangerous('row'), width : 140},
		                 { field: 'properties.incidentDate', displayName: "Incident Date", visible: true, cellFilter: 'date:\'dd-MM-yyyy HH:mm\'', width : 140},
		    ], 
		    data : [],
		    onRegisterApi: function(gridApi){
		    	grid = gridApi;
		    }
	}
	function arrangeButtonForUpdate(row){
		return '<div><button class="glyphicon glyphicon-pencil" ng-click="grid.appScope.updateForm(row)"/></div>';
	}
	function arrangeComboboxForCompleted(row) {

		return '<div>'
					+'<select ng-model="row.entity.properties.completed" '
					+'class="form-control input-sm" ng-disabled=true>'
					+'<option value="false">Finished</option>'
					+'<option value="true">Going on</option>'
					+'</select>'
				+'</div>'
				
	}
	function arrangeComboboxForDangerous(row) {

		return '<div>'
					+'<select ng-model="row.entity.properties.dangerous" '
					+'class="form-control input-sm" ng-disabled=true>'
					+'<option value="false">No</option>'
					+'<option value="true">Yes</option>'
					+'</select>'
				+'</div>'
				
	}
	function arrangeComboboxForType(row) {

		return '<div>'
					+'<select ng-model="row.entity.properties.type" '
					+'class="form-control input-sm" ng-disabled=true>'
					+'<option value="1">Incident Rescue</option>'
					+'<option value="2">Emergency</option>'
					+'</select>'
				+'</div>'
				
	}
	
	$scope.updateForm = function updateForm(row) {
		debugger;
		if(row.entity.properties.type == 1){
			$scope.type = "1";
			$scope.incident.id = row.entity.key.id;
			$scope.incident.completed = row.entity.properties.completed;
			$scope.incident.title = row.entity.properties.title;
			$scope.incident.incidentDate = new Date(row.entity.properties.incidentDate);
		} else {
			$scope.type = "2";
			$scope.incident.id = row.entity.key.id;
			$scope.incident.dangerous = row.entity.properties.dangerous;
			$scope.incident.title = row.entity.properties.title;
			$scope.incident.incidentDate = new Date(row.entity.properties.incidentDate);
		}
	}
})