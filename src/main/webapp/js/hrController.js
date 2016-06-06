var hrApp = angular.module("hrModule", [ 'ngMaterial', 'ui.grid']);

hrApp.controller("hrCtrl", function($scope, $http, $window) {
	
	var selectedPersonel = {};
	var me = this;
	/*
	 * scrollbar
	 *     height: 150px;
    overflow-y: scroll
	 * */
	$scope.setAllDisabled = true;

	//$scope.names = "qwertyuoasdfghjklzxcvbnmö".split("");
	
	$scope.asd = function (personel) {
		debugger;
		
		$scope.name = personel.properties.name;
		$scope.surname = personel.properties.surname;
		$scope.idNumber = personel.properties.idNumber;
		$scope.birthDate = new Date(personel.properties.birthDate);
		$scope.homeNumber = personel.properties.homeNumber;
		$scope.mobileNumber = personel.properties.mobileNumber;
		$scope.emergency1Number = personel.properties.emergency1Number;
		$scope.emergency2Number = personel.properties.emergency2Number;
		$scope.emailPersonel = personel.properties.emailPersonel;
		$scope.emailOrganization = personel.properties.emailOrganization;
		$scope.personalInsurance = personel.properties.personalInsurance;
		$scope.passportInformation = personel.properties.passportInformation;
		$scope.personalInformation = personel.properties.personalInformation;
		$scope.foreignLanguage = personel.properties.foreignLanguage;
		
		$scope.selectPersonel(personel);
	}
	
	
	
	$scope.selectPersonel = function (personel) {
		
		debugger;
		for(var i in $scope.names){
			$scope.names[i].selected = false ;
		}
		personel.selected = true;
		
		me.selectedPersonel = personel;
		me.selectedPersonel.isNew = false;
		
	}
	
	$scope.listAll = function() {
		var obj = {};
		$http({
			method : 'GET',
			url : '/_ah/api/incident/v1/listAllPersonel',
		}).then(function(resp) {
			
			
			
			debugger;
			$scope.names  = resp.data.items;
			alert("Done");
		}, function() {
			alert("An error occured during post request");
		});
	}
	$scope.listAll();
	
	$scope.savePersonel = function() {
		debugger;
			var personel ={};
			personel.name=$scope.name;
			personel.surname=$scope.surname;
			personel.idNumber=$scope.idNumber;
			personel.birthDate=$scope.birthDate;
			personel.homeNumber=$scope.homeNumber;
			personel.mobileNumber=$scope.mobileNumber;
			personel.emergency1Number=$scope.emergency1Number;
			personel.emergency2Number=$scope.emergency2Number;
			personel.emailPersonel=$scope.emailPersonel;
			personel.emailOrganization=$scope.emailOrganization;
			personel.personalInsurance=$scope.personalInsurance;
			personel.passportInformation=$scope.passportInformation;
			personel.personalInformation=$scope.personalInformation;
			personel.foreignLanguage=$scope.foreignLanguage;
			
			if(me.selectedPersonel.isNew)
			{
				personel.isNew = "true";
			}
			else
			{
				personel.isNew = "false";
			}
		
		
		$http({
			method : 'POST',
			url : '/_ah/api/incident/v1/savePersonel',
			data : {
				jsonPersonel : JSON.stringify(personel)
			}
		}).then(function() {
			$window.location.reload();
			
		}, function() {
			alert("An error occured during post request");
		});
	}
	
	$scope.deletePersonel = function () {
		
		var name = me.selectedPersonel.properties.name;
		
		$http({
			method : 'POST',
			url : '/_ah/api/incident/v1/deletePersonel',
			data : {
				name : name
			}
		}).then(function() {
			$scope.listAll();
			alert("Done");
		}, function() {
			alert("An error occured during post request");
		});
		
	}
	
	$scope.editPersonel = function () {
		$scope.setAllDisabled = false;
	}
	
	$scope.addPersonel = function () {
		$scope.setAllDisabled = false;
		$scope.name="";
		$scope.surname="";
		$scope.idNumber="";
		$scope.birthDate="";
		$scope.homeNumber="";
		$scope.mobileNumber="";
		$scope.emergency1Number="";
		$scope.emergency2Number="";
		$scope.emailPersonel="";
		$scope.emailOrganization="";
		$scope.personalInsurance="";
		$scope.passportInformation="";
		$scope.personalInformation="";
		$scope.foreignLanguage="";
		me.selectedPersonel = {};
		me.selectedPersonel.isNew = true;
	}
	
});