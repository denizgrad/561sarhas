var sipApp = angular.module("incidentModule", [ 'ngMaterial', 'ui.grid']);

sipApp.controller("incidentCtrl", function($scope, $http) {

	$scope.urban = {};
	$scope.animalRescue = {};
	$scope.ground = {};

	$scope.postMe = function() {
		$http.get('/_ah/api/incident/v1/test', obj).success(function(response) {
			alert("Done");
		}).error(function(error) {
			alert("An error occured during post request");
		});
	}
	$scope.save = function() {
		debugger;
		var obj = {};
		var type = $scope.type;
		if(type == 1){
			$scope.animalRescue.type = $scope.type;
			obj = $scope.animalRescue;
		} else if (type == 2){
			$scope.urban.type = $scope.type;
			obj = $scope.urban;
		} else if (type == 3){
			$scope.ground.type = $scope.type;
			obj = $scope.ground;
		}
		$http({
			method : 'POST',
			url : '/_ah/api/incident/v1/save',
			data : {
				jsonIncident : JSON.stringify(obj)
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
		                 { field: 'btnDelete', displayName: "", cellTemplate: arrangeButtonForDelete('row'), width : 30},
		                 { field: 'key.id', displayName: "id", visible: false, enableHiding: false},
		                 { field: 'properties.type', displayName: "Type", visible: true, cellTemplate: arrangeComboboxForType('row'), width : 140},
		                 { field: 'properties.title', displayName: "Title", width : 140},
//		                 { field: 'properties.date', displayName: "Incident Date", visible: true, cellFilter: 'date:\'dd-MM-yyyy HH:mm\'', width : 140},
		    ], 
		    data : [],
		    onRegisterApi: function(gridApi){
		    	grid = gridApi;
		    }
	}
	function arrangeButtonForUpdate(row){
		return '<div><button class="glyphicon glyphicon-pencil" ng-click="grid.appScope.updateForm(row)"/></div>';
	}
	function arrangeButtonForDelete(row){
		return '<div><button class="glyphicon glyphicon-remove" ng-click="grid.appScope.deleteRow(row)"/></div>';
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
	function arrangeComboboxForEarthquake(row) {

		return '<div>'
					+'<select ng-model="row.entity.properties.earthquake" '
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
					+'<option value="1">Animal Rescue</option>'
					+'<option value="2">Urban SAR</option>'
					+'<option value="3">Ground SAR</option>'
					+'</select>'
				+'</div>'
				
	}
	
	$scope.clear = function clear(row) {
		$scope.animalRescue = {};
		$scope.urban = {};
		$scope.ground = {};
		$scope.type = '1';
	}
	
	$scope.deleteRow = function deleteRow(row) {
		var obj = {};
		debugger;
		var index = $scope.gridOptions.data.indexOf(row.entity);
		$scope.gridOptions.data.splice(index, 1); 
		
		$http({
			method : 'POST',
			url : '/_ah/api/incident/v1/delete',
			data : {
				oidIncident : row.entity.key.id
			}
		}).then(function(resp) {
			$scope.listAll();
			alert("Done");
		}, function() {
			alert("An error occured during post request");
		});
	}
	$scope.updateForm = function updateForm(row) {
		debugger;
		if(row.entity.properties.type == 1){
			$scope.type = "1";
			$scope.animalRescue.id = row.entity.key.id;
			$scope.animalRescue.completed = row.entity.properties.completed;
			$scope.animalRescue.where = row.entity.properties.where;
			$scope.animalRescue.location = row.entity.properties.location;
			$scope.animalRescue.animalType = row.entity.properties.animalType;
			$scope.animalRescue.condition = row.entity.properties.condition;
			$scope.animalRescue.date = new Date(row.entity.properties.date);
		} else if(row.entity.properties.type == 2){
			$scope.type = "2";
			$scope.urban.id = row.entity.key.id;
			$scope.urban.title = row.entity.properties.title;
			$scope.urban.earthquake = row.entity.properties.earthquake;
			$scope.urban.latitude = row.entity.properties.latitude;
			$scope.urban.longitude = row.entity.properties.longitude;
			$scope.urban.country = row.entity.properties.country;
			$scope.urban.city = row.entity.properties.city;
			$scope.urban.village = row.entity.properties.village;
			$scope.urban.depth = row.entity.properties.depth;
			$scope.urban.magnitude = row.entity.properties.magnitude;
			$scope.urban.longitude = row.entity.properties.longitude;
			$scope.urban.date = new Date(row.entity.properties.date);
			$scope.urban.location = row.entity.properties.location;
			$scope.urban.quantity = row.entity.properties.quantity;
			$scope.urban.buildingType = row.entity.properties.buildingType;
			$scope.urban.population = row.entity.properties.population;
		}
		else if(row.entity.properties.type == 3){
			$scope.type = "3";
			$scope.ground.id = row.entity.key.id;
			$scope.ground.intelligenceSource = row.entity.properties.intelligenceSource;
			$scope.ground.title = row.entity.properties.title;
			$scope.ground.contactInfo = row.entity.properties.contactInfo;
			$scope.ground.physicalInfo = row.entity.properties.physicalInfo;
			$scope.ground.clothingInfo = row.entity.properties.clothingInfo;
			$scope.ground.lastSeenDescription = row.entity.properties.lastSeenDescription;
			//$scope.incident.incidentDate = new Date(row.entity.properties.incidentDate);
		}
	}
})